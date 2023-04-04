import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/controllers/enums/payment_type_enum.dart';
import 'package:cashier_app/controllers/enums/transaction_status_enum.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/models/menu/price_model.dart';
import 'package:cashier_app/models/report/dashboard_report_model.dart';
import 'package:cashier_app/models/transaction/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class TransactionController extends GetxController {
  final _transactionCollection =
      FirebaseFirestore.instance.collection(DocumentName.TRANSACTION.name.toLowerCase());
  DashboardReportModel dashboardReportModel = DashboardReportModel();
  int menuQty = 1;
  TransactionModel transaction = TransactionModel();
  double? subTotal;
  double maxGraphIncome = 0;

  Stream<QuerySnapshot<TransactionModel>> streamDashboardReport(
      {required String merchantId, required String locationId}) {
    var today = DateTime.now();
    var dataToReturn = <TransactionModel>[];
    return _transactionCollection
        .where('merchantId', isEqualTo: merchantId)
        .where('locationId', isEqualTo: locationId)
        .where('createdAt', isGreaterThan: Timestamp.fromDate(DateTime(2023)))
        .withConverter<TransactionModel>(fromFirestore: (snapshot, options) {
      return TransactionModel.fromJson(snapshot.id, snapshot.data()!);
    }, toFirestore: (value, options) {
      return {};
    }).snapshots();
  }

  Future<List<TransactionModel>> transactionList(
      {required String merchantId, required String locationId}) async {
    return await _transactionCollection
        .where('merchantId', isEqualTo: merchantId)
        .where('locationId', isEqualTo: locationId)
        .withConverter<TransactionModel>(fromFirestore: (snapshot, options) {
          return TransactionModel.fromJson(snapshot.id, snapshot.data()!);
        }, toFirestore: (value, options) {
          return {};
        })
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<void> getSingleTransaction(String transactionId) async {
    await _transactionCollection
        .doc(transactionId)
        .withConverter<TransactionModel>(fromFirestore: (snapshot, options) {
          return TransactionModel.fromJson(snapshot.id, snapshot.data()!);
        }, toFirestore: (value, options) {
          return {};
        })
        .get()
        .then((value) async {
          var menu = await _getTransactionMenu(transactionId);
          transaction = value.data()!.copyWith(menus: menu);
        });
  }

  Future<List<MenuModel>> _getTransactionMenu(String transactionId) async {
    return await _transactionCollection
        .doc(transactionId)
        .collection('menu')
        .withConverter<MenuModel>(fromFirestore: (snapshot, options) {
          return MenuModel.fromJson(snapshot.id, snapshot.data()!);
        }, toFirestore: (value, options) {
          return {};
        })
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<Map<String, List<TransactionModel>>> groupedTransaction(
      {required String merchantId, required String locationId}) async {
    var targetDate = DateTime.now().subtract(Duration(days: 7));
    return await _transactionCollection
        .where('merchantId', isEqualTo: merchantId)
        .where('locationId', isEqualTo: locationId)
        .where('createdAt',
            isGreaterThan: Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 6))))
        .withConverter<TransactionModel>(fromFirestore: (snapshot, options) {
          return TransactionModel.fromJson(snapshot.id, snapshot.data()!);
        }, toFirestore: (value, options) {
          return {};
        })
        .get()
        .then((value) {
          var data = value.docs.map((e) => e.data()).toList();
          maxGraphIncome =
              data.map((e) => e.grandTotal ?? 0).reduce((curr, next) => curr > next ? curr : next);
          var aa = groupBy<TransactionModel, String>(
              data, (key) => DateFormat("d", 'id_ID').format(key.createdAt!));
          log(aa.toString());
          return aa;
        });
  }

  Future<void> uploadTransaction(
      {required String userId, required String locationId, required String merchantId}) async {
    await _transactionCollection
        .add(transaction
            .copyWith(
              createdAt: DateTime.now(),
              currency: "Rupiah",
              discNominal: 0,
              handledBy: userId,
              locationId: locationId,
              merchantId: merchantId,
              paymentType: PaymentType.CASH,
              status: TransactionStatus.DONE,
            )
            .toJson())
        .then((value) async {
      await _createMenusTransaction(value.id).then((value) {
        transaction = TransactionModel();
      });
    });
  }

  Future<void> _createMenusTransaction(String transactionId) async {
    Future.wait(transaction.menus!
        .map((e) => _transactionCollection.doc(transactionId).collection("menus").add(e.toJson())));
  }

  Future<List<MenuModel>> getTransactionMenu(String transactionId) async {
    return await _transactionCollection
        .doc(transactionId)
        .collection(DocumentName.MENUS.name.toLowerCase())
        .withConverter<MenuModel>(
          fromFirestore: (snapshot, options) {
            return MenuModel.fromJson(snapshot.id, snapshot.data()!);
          },
          toFirestore: (value, options) => value.toJson(),
        )
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  double getSubTotal() {
    return transaction.menus!.fold(
        0.0, (previousValue, element) => previousValue + (element.price!.price! * element.qty!));
  }

  void insertGrandTotal() {
    transaction.grandTotal = transaction.menus!.fold(
        0.0, (previousValue, element) => previousValue! + (element.price!.price! * element.qty!));
    transaction.subTotal = transaction.menus!.fold(
        0.0, (previousValue, element) => previousValue! + (element.price!.price! * element.qty!));
  }
}

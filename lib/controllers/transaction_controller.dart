import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/controllers/enums/payment_type_enum.dart';
import 'package:cashier_app/controllers/enums/transaction_status_enum.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/models/report/dashboard_report_model.dart';
import 'package:cashier_app/models/transaction/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final _transactionCollection =
      FirebaseFirestore.instance.collection(DocumentName.TRANSACTION.name.toLowerCase());
  DashboardReportModel dashboardReportModel = DashboardReportModel();
  int menuQty = 1;
  TransactionModel transaction = TransactionModel();
  double? subTotal;

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

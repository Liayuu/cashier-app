import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
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
    return transaction.menus!
        .fold(0.0, (previousValue, element) => previousValue + element.price!.price!);
  }

  void insertGrandTotal() {
    transaction.grandTotal = transaction.menus!
        .fold(0.0, (previousValue, element) => previousValue! + element.price!.price!);
  }
}

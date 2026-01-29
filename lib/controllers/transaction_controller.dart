
import 'package:cashier_app/controllers/enums/payment_type_enum.dart';
import 'package:cashier_app/controllers/enums/transaction_status_enum.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/models/menu/price_model.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';
import 'package:cashier_app/models/report/dashboard_report_model.dart';
import 'package:cashier_app/models/transaction/transaction_model.dart';
import 'package:cashier_app/services/local_database.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class TransactionController extends GetxController {
  final _db = LocalDatabase();
  DashboardReportModel dashboardReportModel = DashboardReportModel();
  int menuQty = 1;
  TransactionModel transaction = TransactionModel();
  double? subTotal;
  double maxGraphIncome = 0;

  Future<List<TransactionModel>> streamDashboardReport({
    required String merchantId,
    required String locationId,
  }) async {
    final raw = await _db.getTransactions(
        merchantId: merchantId, locationId: locationId, sinceDate: DateTime(2023));
    return raw
        .map((m) => TransactionModel.fromJson(m['__id'] as String, Map<String, dynamic>.from(m)))
        .toList();
  }

  Future<List<TransactionModel>> transactionList(
      {required String merchantId, required String locationId}) async {
    final raw = await _db.getTransactions(merchantId: merchantId, locationId: locationId);
    return raw
        .map((m) => TransactionModel.fromJson(m['__id'] as String, Map<String, dynamic>.from(m)))
        .toList();
  }

  Future<void> getSingleTransaction(String transactionId) async {
    final raw = await _db.getTransactionById(transactionId);
    if (raw == null) return;
    final base = Map<String, dynamic>.from(raw);
    final id = base['__id'] as String;
    final model = TransactionModel.fromJson(id, base);
    final menu = await _getTransactionMenu(transactionId);
    final promo = await _getTransactionPromo(transactionId);
    transaction = model.copyWith(menus: menu, promos: promo);
  }

  Future<List<PromotionModel>> _getTransactionPromo(String transactionId) async {
    final raw = await _db.getTransactionById(transactionId);
    if (raw == null) return [];
    final promos = (raw['promos'] as List<dynamic>?) ?? [];
    return promos
        .map((p) => PromotionModel.fromJson(p['id']?.toString() ?? '', Map<String, dynamic>.from(p)))
        .toList();
  }

  Future<PriceModel> _getTransactionMenuPrice(String transactionId, String menuId) async {
    final raw = await _db.getTransactionById(transactionId);
    if (raw == null) throw Exception('Transaction not found');
    final menus = (raw['menus'] as List<dynamic>?) ?? [];
    final found = menus.firstWhere((m) => (m['id']?.toString() ?? '') == menuId, orElse: () => null);
    if (found == null) throw Exception('Price not found');
    final price = found['price'] as Map<String, dynamic>?;
    return PriceModel.fromJson(price?['id']?.toString() ?? '', Map<String, dynamic>.from(price ?? {}));
  }

  Future<List<MenuModel>> _getTransactionMenu(String transactionId) async {
    final raw = await _db.getTransactionById(transactionId);
    if (raw == null) return [];
    final menus = (raw['menus'] as List<dynamic>?) ?? [];
    return Future.wait(menus.map((m) async {
      final map = Map<String, dynamic>.from(m as Map);
      final id = map['id']?.toString() ?? '';
      final menu = MenuModel.fromJson(id, map);
      // Attach price if present
      if (map.containsKey('price') && map['price'] is Map) {
        final priceMap = Map<String, dynamic>.from(map['price'] as Map);
        menu.copyWith(price: PriceModel.fromJson(priceMap['id']?.toString() ?? '', priceMap));
      }
      return menu;
    }).toList());
  }

  Future<Map<String, List<TransactionModel>>> groupedTransaction(
      {required String merchantId, required String locationId}) async {
    var targetDate = DateTime.now().subtract(const Duration(days: 7));
    final raw = await _db.getTransactions(
        merchantId: merchantId,
        locationId: locationId,
        sinceDate: DateTime.now().subtract(const Duration(days: 6)));
    final data = raw.map((m) => TransactionModel.fromJson(m['__id'] as String, Map<String, dynamic>.from(m))).toList();
    if (data.isNotEmpty) {
      maxGraphIncome = data.map((e) => e.grandTotal ?? 0).reduce((curr, next) => curr > next ? curr : next);
    }
    final aa = groupBy<TransactionModel, String>(data, (key) => DateFormat("d", 'id_ID').format(key.createdAt!));
    return aa;
  }

  Future<void> uploadTransaction(
      {required String userId, required String locationId, required String merchantId}) async {
    final json = transaction
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
        .toJson();
    final id = await _db.addTransaction(json);
    transaction = TransactionModel();
  }

  Future<void> _createMenusTransaction(String transactionId) async {
    // Menus are stored inline inside transaction for local storage.
  }

  Future<void> _createPromotionTransaction(String transactionId) async {
    // Promotions are stored inline inside transaction for local storage.
  }

  Future<List<MenuModel>> getTransactionMenu(String transactionId) async {
    return await _getTransactionMenu(transactionId);
  }

  double getSubTotal() {
    return transaction.menus!.fold(
        0.0, (previousValue, element) => previousValue + (element.price!.price! * element.qty!));
  }

  void insertGrandTotal() {
    transaction.grandTotal = transaction.menus!.fold(
        0.0, (previousValue, element) => previousValue! + (element.price!.price! * element.qty!));
    // transaction.subTotal = transaction.menus!.fold(
    //     0.0, (previousValue, element) => previousValue! + (element.price!.price! * element.qty!));
  }

  void insertSubTotal() {
    transaction.subTotal = transaction.menus!
        .fold(0.0, (previousValue, element) => previousValue! + (element.buyingPrice!));
  }
}

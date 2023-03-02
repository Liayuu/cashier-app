import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/controllers/user_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.lazyPut(() => TransactionController(), fenix: true);
    Get.lazyPut(() => MerchantController(), fenix: true);
  }
}

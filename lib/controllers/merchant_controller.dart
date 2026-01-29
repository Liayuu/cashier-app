import 'dart:developer';

import 'package:cashier_app/controllers/enums/branch_type_enum.dart';
import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/controllers/enums/merchant_type_enum.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/merchant/branch_model.dart';
import 'package:cashier_app/models/merchant/merchant_model.dart';
import 'package:get/get.dart';
import 'package:cashier_app/services/local_database.dart';
import 'package:cashier_app/services/local_file_service.dart';
import 'package:image_picker/image_picker.dart';

class MerchantController extends GetxController {
  final _collectionName = DocumentName.MERCHANT.name.toLowerCase();
  MerchantModel merchant = MerchantModel();
  BranchModel branch = BranchModel();
  XFile? newLogo;
  XFile? newBackground;

  Future<void> initializeMerchant(String? employeeAt) async {
    if (merchant == MerchantModel()) {
      await fetchMerchantModel(employeeAt!);
    }
  }

  Future<void> fetchMerchantModel(String merchantId) async {
    final data =
        await LocalDatabase.instance.getDocument(_collectionName, merchantId);
    if (data != null) {
      merchant = MerchantModel.fromJson(data['id'], data);
      await _fetchBranch(merchantId);
      update();
    }
  }

  Future<void> _fetchBranch(String merchantId) async {
    final branchCollection = '${_collectionName}_branch';
    final docs = await LocalDatabase.instance
        .whereEquals(branchCollection, 'merchantId', merchantId);
    if (docs.isNotEmpty) {
      branch = BranchModel.fromJson(docs.first['id'], docs.first);
      branch.logoUrl = branch.logo; // local path
      branch.backgroundUrl = branch.background;
      update();
    }
  }

  Future<String> _uploadImage(String merchantId, XFile file) async {
    final destination = "merchant/$merchantId";
    return await LocalFileService.instance.uploadFile(file, destination);
  }

  Future<void> addOrUpdateMerchant() async {
    if (merchant.id != null) {
      if (branch.id != null) {
        if (newLogo != null) {
          await _uploadImage(branch.id!, newLogo!).then((value) {
            branch.logo = value;
          });
        }
        if (newBackground != null) {
          await _uploadImage(branch.id!, newBackground!).then((value) {
            branch.background = value;
          });
        }
      }
      final branchCollection = '${_collectionName}_branch';
      if (branch.id != null) {
        await LocalDatabase.instance
            .updateDocument(branchCollection, branch.id!, branch.toJson());
      }
      await LocalDatabase.instance.updateDocument(_collectionName, merchant.id!,
          merchant.copyWith(updatedAt: DateTime.now()).toJson());
      await fetchMerchantModel(merchant.id!);
    } else {
      final data = merchant
          .copyWith(
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              status: StatusEnum.ACTIVE,
              type: MerchantType.RESTAURANT)
          .toJson();
      final id =
          await LocalDatabase.instance.addDocument(_collectionName, data);
      merchant = MerchantModel.fromJson(id, data);
      log(merchant.toString(), name: "Merchant");
      final branchCollection = '${_collectionName}_branch';
      final branchData = branch
          .copyWith(
              branchType: BranchType.MAIN_BRANCH,
              status: StatusEnum.ACTIVE,
              merchantId: merchant.id)
          .toJson();
      final branchId = await LocalDatabase.instance
          .addDocument(branchCollection, branchData);
      branch = BranchModel.fromJson(branchId, branchData);
      if (newLogo != null) {
        branch.logo = await _uploadImage(branch.id!, newLogo!);
      }
      if (newBackground != null) {
        branch.background = await _uploadImage(branch.id!, newBackground!);
      }
      await LocalDatabase.instance
          .updateDocument(branchCollection, branch.id!, branch.toJson());
      branch.logoUrl = branch.logo;
      branch.backgroundUrl = branch.background;
    }
  }

  Future<String> uploadFile(XFile file, String destination) async {
    return await LocalFileService.instance.uploadFile(file, destination);
  }
}

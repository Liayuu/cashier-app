import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/models/merchant/branch_model.dart';
import 'package:cashier_app/models/merchant/merchant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MerchantController extends GetxController {
  final _merchantCollection =
      FirebaseFirestore.instance.collection(DocumentName.MERCHANT.name.toLowerCase());
  MerchantModel merchant = MerchantModel();
  BranchModel branch = BranchModel();

  Future<void> fetchMerchantModel(String merchantId) async {
    await _merchantCollection
        .doc(merchantId)
        .withConverter<MerchantModel>(
            fromFirestore: (snapshot, options) {
              return MerchantModel.fromJson(snapshot.id, snapshot.data()!);
            },
            toFirestore: (value, options) => value.toJson())
        .get()
        .then((value) async {
      merchant = value.data()!;
      await _fetchBranch(merchantId);
      update();
    });
  }

  Future<void> _fetchBranch(String merchantId) async {
    await _merchantCollection
        .doc(merchantId)
        .collection('branch')
        .withConverter<BranchModel>(
            fromFirestore: (snapshot, options) {
              return BranchModel.fromJson(snapshot.id, snapshot.data()!);
            },
            toFirestore: (value, options) => value.toJson())
        .get()
        .then((value) async {
      branch = value.docs.first.data();
      await FirebaseStorage.instance.ref(branch.logo).getDownloadURL().then((value) {
        branch.logo = value;
      });
      await FirebaseStorage.instance.ref(branch.background).getDownloadURL().then((value) {
        branch.background = value;
      });
    });
  }
}

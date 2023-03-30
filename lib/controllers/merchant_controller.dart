import 'dart:io';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/models/merchant/branch_model.dart';
import 'package:cashier_app/models/merchant/merchant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MerchantController extends GetxController {
  final _merchantCollection =
      FirebaseFirestore.instance.collection(DocumentName.MERCHANT.name.toLowerCase());
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
      update();
    });
  }

  Future<String> _uploadImage(String merchantId, XFile file) async {
    final destination = "/merchant/$merchantId";
    return await uploadFile(file, destination);
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
            branch.logo = value;
          });
        }
      }
      await _merchantCollection
          .doc(merchant.id)
          .collection("branch")
          .doc(branch.id)
          .update(branch.toJson());
      await _merchantCollection
          .doc(merchant.id)
          .update(merchant.copyWith(updatedAt: DateTime.now()).toJson());
    } else {
      if (newLogo != null) {
        await _uploadImage(branch.id!, newLogo!).then((value) {
          branch.logo = value;
        });
      }
      if (newBackground != null) {
        await _uploadImage(branch.id!, newBackground!).then((value) {
          branch.logo = value;
        });
      }
      await _merchantCollection.add(merchant.toJson()).then((value) async {
        await _merchantCollection.doc(value.id).collection("branch").add(branch.toJson());
      });
    }
  }

  Future<String> uploadFile(XFile file, String destination) async {
    var directory = "$destination/${DateTime.now().millisecondsSinceEpoch}-${file.name}";
    var ref = FirebaseStorage.instance.ref(directory);
    if (kIsWeb) {
      await file.readAsBytes().then((value) async {
        await ref.putData(value);
      });
    } else {
      await ref.putFile(File(file.path));
    }

    return directory;
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/categories_model.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/models/menu/price_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MenusController extends GetxController {
  final _menuCollection =
      FirebaseFirestore.instance.collection(DocumentName.MENUS.name.toLowerCase());
  final _categoryCollection =
      FirebaseFirestore.instance.collection(DocumentName.CATEGORIES.name.toLowerCase());
  // List<MenuModel> listMenu = <MenuModel>[];
  List<CategoriesModel> listCategory = <CategoriesModel>[];
  CategoriesModel currentCategory = CategoriesModel();
  MenuModel menu = MenuModel();
  XFile? newImage;
  double? newPrice;
  String? newCategory;

  Stream<List<CategoriesModel>> streamEditCategory(String merchantId, String locationId) {
    return _categoryCollection
        .where('merchantId', isEqualTo: merchantId)
        .where('appliedAt', arrayContains: locationId)
        .withConverter<CategoriesModel>(
            fromFirestore: (snapshot, options) =>
                CategoriesModel.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (value, options) => value.toJson())
        .snapshots()
        .asyncMap((event) {
      return Future.wait(event.docs.map((e) => fetchCategoriesWithMenu(param: e.data())));
    });
  }

  Future<void> fetchCategories(String merchantId, String locationId) async {
    return _categoryCollection
        .where('merchantId', isEqualTo: merchantId)
        .where('appliedAt', arrayContains: locationId)
        .withConverter<CategoriesModel>(
            fromFirestore: (snapshot, options) =>
                CategoriesModel.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (value, options) => value.toJson())
        .get()
        .then((value) {
      listCategory.assignAll(value.docs.map((e) => e.data()).toList());
      update();
    });
  }

  Future<void> addNewCategory(
      {required String merchantId,
      required String locationId,
      required String categoryName}) async {
    await _categoryCollection
        .add(CategoriesModel(
                appliedAt: [locationId],
                createdAt: DateTime.now(),
                merchantId: merchantId,
                name: categoryName,
                status: StatusEnum.ACTIVE,
                updatedAt: DateTime.now())
            .toJson())
        .then((value) async {
      await value
          .withConverter<CategoriesModel>(
            fromFirestore: (snapshot, options) =>
                CategoriesModel.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          )
          .get()
          .then((value) {
        listCategory.add(value.data()!);
        update();
      });
    });
  }

  Future<CategoriesModel> fetchCategoriesWithMenu({required CategoriesModel param}) async {
    if (param.items?.isNotEmpty ?? false) {
      return await _menuCollection
          .where('__name__', whereIn: param.items)
          .withConverter<MenuModel>(
              fromFirestore: (snapshot, options) =>
                  MenuModel.fromJson(snapshot.id, snapshot.data()!),
              toFirestore: (value, options) => value.toJson())
          .get()
          .then((value) {
        return value.docs.map((e) => e.data()).toList();
        // return param.copyWith(menus: value.docs.map((e) => e.data()).toList());
      }).then((value) async {
        return Future.wait(value.map((e) async {
          var dlLink = await FirebaseStorage.instance.ref(e.image).getDownloadURL();
          return e.copyWith(downloadLink: dlLink);
        }));
      }).then((value) => param.copyWith(menus: value));
    } else {
      return param;
    }
  }

  Future<MenuModel> fetchMenuWithPrice(MenuModel param) async {
    return await _menuCollection
        .doc(param.id)
        .collection('prices')
        .withConverter<PriceModel>(
          fromFirestore: (snapshot, options) => PriceModel.fromJson(snapshot.id, snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .get()
        .then((value) => param.copyWith(price: value.docs.first.data()));
  }

  Future<void> fetchMenuForEdit(MenuModel data) async {
    await fetchMenuWithPrice(data).then((value) {
      menu = value;
      update();
    });
  }

  Future<String> _uploadImage(String menuId, XFile file) async {
    final destination = "/menu/$menuId";
    return await uploadFile(file, destination);
  }

  Future<void> addOrUpdateMenu({String? merchantId, String? locationId}) async {
    if (menu.id != null) {
      if (newImage != null) {
        await _uploadImage(menu.id!, newImage!).then((value) {
          menu.image = value;
        });
      }
      await _menuCollection.doc(menu.id).update(menu.copyWith(updatedAt: DateTime.now()).toJson());
      await _menuCollection
          .doc(menu.id)
          .collection('prices')
          .doc(menu.price!.id)
          .update(menu.price!.copyWith(updatedAt: DateTime.now(), price: newPrice).toJson());
      if (listCategory.firstWhere((e) => e.isChoosed).id != currentCategory.id) {
        currentCategory.items!.removeWhere((e) => e == menu.id);
        var newCat = listCategory.firstWhere((e) => e.isChoosed);
        newCat.items!.add(menu.id!);
        await _categoryCollection
            .doc(currentCategory.id)
            .update(currentCategory.copyWith(updatedAt: DateTime.now()).toJson());
        await _categoryCollection
            .doc(newCat.id)
            .update(newCat.copyWith(updatedAt: DateTime.now()).toJson());
      }
    } else {
      await _menuCollection
          .add(menu
              .copyWith(
                  menuAt: merchantId!,
                  specifiedAt: [locationId!],
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now())
              .toJson())
          .then((value) async {
        menu = await value
            .withConverter<MenuModel>(
              fromFirestore: (snapshot, options) =>
                  MenuModel.fromJson(snapshot.id, snapshot.data()!),
              toFirestore: (data, options) => data.toJson(),
            )
            .get()
            .then((data) => data.data() ?? MenuModel());
        var newCat = listCategory.firstWhere((e) => e.isChoosed);
        newCat.items ??= [];
        newCat.items!.add(value.id);
        await _menuCollection.doc(value.id).collection('prices').add(PriceModel(
                price: newPrice,
                createdAt: DateTime.now(),
                locationId: [locationId],
                merchantId: merchantId,
                status: StatusEnum.ACTIVE,
                updatedAt: DateTime.now())
            .toJson());
        await _categoryCollection
            .doc(newCat.id)
            .update(newCat.copyWith(updatedAt: DateTime.now()).toJson());
        await _uploadImage(value.id, newImage!).then((img) async {
          await _menuCollection
              .doc(menu.id)
              .update(menu.copyWith(updatedAt: DateTime.now(), image: img).toJson());
        });
      });
    }
  }

  Future<String> uploadFile(XFile file, String destination) async {
    var directory = "$destination/${DateTime.now().millisecondsSinceEpoch}-${file.name}";
    var ref = FirebaseStorage.instance.ref(directory);
    var data = File(file.path);
    await ref.putFile(data);
    return directory;
  }
}

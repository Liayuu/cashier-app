import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/categories_model.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/models/menu/price_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MenusController extends GetxController {
  final _menuCollection =
      FirebaseFirestore.instance.collection(DocumentName.MENUS.name.toLowerCase());
  final _categoryCollection =
      FirebaseFirestore.instance.collection(DocumentName.CATEGORIES.name.toLowerCase());
  // List<MenuModel> listMenu = <MenuModel>[];
  List<CategoriesModel> listCategory = <CategoriesModel>[];
  CategoriesModel currentCategory = CategoriesModel();
  MenuModel menu = MenuModel();

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

  Future<CategoriesModel> fetchCategoriesWithMenu({required CategoriesModel param}) async {
    return await _menuCollection
        .where('__name__', whereIn: param.items)
        .withConverter<MenuModel>(
            fromFirestore: (snapshot, options) => MenuModel.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (value, options) => value.toJson())
        .get()
        .then((value) async {
      return param.copyWith(menus: value.docs.map((e) => e.data()).toList());
    });
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

  Future<void> addOrUpdateMenu({String? merchantId, String? locationId}) async {
    if (menu.id != null) {
      await _menuCollection.doc(menu.id).update(menu.copyWith(updatedAt: DateTime.now()).toJson());
      await _menuCollection
          .doc(menu.id)
          .collection('prices')
          .doc(menu.price!.id)
          .update(menu.price!.copyWith(updatedAt: DateTime.now()).toJson());
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
        var newCat = listCategory.firstWhere((e) => e.isChoosed);
        newCat.items!.add(value.id);
        await _menuCollection.doc(value.id).collection('price').add(menu.price!
            .copyWith(
                createdAt: DateTime.now(),
                locationId: [locationId],
                merchantId: merchantId,
                status: StatusEnum.ACTIVE,
                updatedAt: DateTime.now())
            .toJson());
        await _categoryCollection
            .doc(newCat.id)
            .update(newCat.copyWith(updatedAt: DateTime.now()).toJson());
      });
    }
  }
}

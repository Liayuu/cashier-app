import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/categories_model.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/models/menu/price_model.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';
import 'package:cashier_app/services/local_database.dart';
import 'package:get/get.dart';
import 'package:cashier_app/services/local_file_service.dart';
import 'package:image_picker/image_picker.dart';

class MenusController extends GetxController {
  final _menuCollectionName = DocumentName.MENUS.name.toLowerCase();
  final _categoryCollectionName = DocumentName.CATEGORIES.name.toLowerCase();
  // List<MenuModel> listMenu = <MenuModel>[];
  List<CategoriesModel> listCategory = <CategoriesModel>[];
  CategoriesModel currentCategory = CategoriesModel();
  MenuModel menu = MenuModel();
  XFile? newImage;
  double? newPrice;
  String? newCategory;

  Stream<List<CategoriesModel>> streamEditCategory(
      String merchantId, String locationId,
      {String? searchMenu}) {
    // streams are not implemented for local json store; return a one-shot future converted to stream
    return Stream.fromFuture(LocalDatabase.instance
        .whereEquals(_categoryCollectionName, 'merchantId', merchantId)
        .then((docs) => Future.wait(docs.map((d) => fetchCategoriesWithMenu(
            param: CategoriesModel.fromJson(d['id'], d),
            searchMenu: searchMenu)))));
  }

  Future<void> fetchCategories(String merchantId, String locationId) async {
    final docs = await LocalDatabase.instance
        .whereEquals(_categoryCollectionName, 'merchantId', merchantId);
    final filtered = docs
        .where((d) => (d['appliedAt'] as List?)?.contains(locationId) ?? false)
        .toList();
    listCategory.assignAll(
        filtered.map((d) => CategoriesModel.fromJson(d['id'], d)).toList());
    update();
    return;
  }

  Future<void> addNewCategory(
      {required String merchantId,
      required String locationId,
      required String categoryName}) async {
    final data = CategoriesModel(
            appliedAt: [locationId],
            createdAt: DateTime.now(),
            merchantId: merchantId,
            name: categoryName,
            status: StatusEnum.ACTIVE,
            updatedAt: DateTime.now())
        .toJson();
    final id =
        await LocalDatabase.instance.addDocument(_categoryCollectionName, data);
    listCategory.add(CategoriesModel.fromJson(id, data));
    update();
  }

  Future<CategoriesModel> fetchCategoriesWithMenu(
      {required CategoriesModel param, String? searchMenu}) async {
    if (param.items?.isNotEmpty ?? false) {
      final menus =
          await LocalDatabase.instance.getCollection(_menuCollectionName);
      var data = menus
          .where((m) => param.items!.contains(m['id']))
          .map((m) => MenuModel.fromJson(m['id'], m))
          .toList();
      if (searchMenu != null && searchMenu != '') {
        data = data
            .where((element) =>
                element.name
                    ?.toLowerCase()
                    .contains(searchMenu.toLowerCase()) ??
                false)
            .toList();
      }
      final withImages = await Future.wait(data.map((e) async {
        log(e.image ?? "null", name: "Image");
        final dlLink = e.image; // image is local path already
        return e.copyWith(downloadLink: dlLink);
      }));
      return param.copyWith(menus: withImages);
    } else {
      return param;
    }
  }

  Future<MenuModel> fetchMenuWithPrice(MenuModel param) async {
    final pricesCollection = '${_menuCollectionName}_prices';
    final prices = await LocalDatabase.instance
        .whereEquals(pricesCollection, 'menuId', param.id);
    if (prices.isNotEmpty) {
      return param.copyWith(
          price: PriceModel.fromJson(prices.first['id'], prices.first));
    }
    return param;
  }

  Future<PromotionModel?> getMenuPromo(
      {required MenuModel data, required int qty}) async {
    final promoCollection = '${_menuCollectionName}_promotion';
    final promos = await LocalDatabase.instance
        .whereEquals(promoCollection, 'menuId', data.id);
    if (promos.isNotEmpty) {
      final promoModels =
          promos.map((p) => PromotionModel.fromJson(p['id'], p)).toList();
      // Simple selection: pick the first active promo whose start/end range contains now
      final now = DateTime.now();
      for (var p in promoModels) {
        if ((p.startTime == null || p.startTime!.isBefore(now)) &&
            (p.endTime == null || p.endTime!.isAfter(now))) {
          return p;
        }
      }
      return promoModels.first;
    }
    return null;
  }

  Future<void> fetchMenuForEdit(MenuModel data) async {
    await fetchMenuWithPrice(data).then((value) {
      menu = value;
      update();
    });
  }

  Future<String> _uploadImage(String menuId, XFile file) async {
    final destination = "menu/$menuId";
    return await LocalFileService.instance.uploadFile(file, destination);
  }

  Future<void> addOrUpdateMenu({String? merchantId, String? locationId}) async {
    if (menu.id != null) {
      if (newImage != null) {
        menu.image = await _uploadImage(menu.id!, newImage!);
      }
      await LocalDatabase.instance.updateDocument(_menuCollectionName, menu.id!,
          menu.copyWith(updatedAt: DateTime.now()).toJson());
      final pricesCollection = '${_menuCollectionName}_prices';
      if (menu.price != null) {
        await LocalDatabase.instance.updateDocument(
            pricesCollection,
            menu.price!.id!,
            menu.price!
                .copyWith(updatedAt: DateTime.now(), price: newPrice)
                .toJson());
      }
      if (listCategory.firstWhere((e) => e.isChoosed).id !=
          currentCategory.id) {
        currentCategory.items!.removeWhere((e) => e == menu.id);
        var newCat = listCategory.firstWhere((e) => e.isChoosed);
        newCat.items!.add(menu.id!);
        await LocalDatabase.instance.updateDocument(
            _categoryCollectionName,
            currentCategory.id!,
            currentCategory.copyWith(updatedAt: DateTime.now()).toJson());
        await LocalDatabase.instance.updateDocument(_categoryCollectionName,
            newCat.id!, newCat.copyWith(updatedAt: DateTime.now()).toJson());
      }
    } else {
      final data = menu
          .copyWith(
              menuAt: merchantId!,
              specifiedAt: [locationId!],
              createdAt: DateTime.now(),
              updatedAt: DateTime.now())
          .toJson();
      final id =
          await LocalDatabase.instance.addDocument(_menuCollectionName, data);
      menu = MenuModel.fromJson(id, data);
      var newCat = listCategory.firstWhere((e) => e.isChoosed);
      newCat.items ??= [];
      newCat.items!.add(menu.id!);
      final pricesCollection = '${_menuCollectionName}_prices';
      final priceData = PriceModel(
              price: newPrice,
              createdAt: DateTime.now(),
              locationId: [locationId],
              merchantId: merchantId,
              status: StatusEnum.ACTIVE,
              updatedAt: DateTime.now())
          .toJson();
      final priceId =
          await LocalDatabase.instance.addDocument(pricesCollection, priceData);
      await LocalDatabase.instance.updateDocument(_categoryCollectionName,
          newCat.id!, newCat.copyWith(updatedAt: DateTime.now()).toJson());
      if (newImage != null) {
        final img = await _uploadImage(menu.id!, newImage!);
        menu = menu.copyWith(updatedAt: DateTime.now(), image: img);
        await LocalDatabase.instance
            .updateDocument(_menuCollectionName, menu.id!, menu.toJson());
      }
    }
  }

  Future<String> uploadFile(XFile file, String destination) async {
    return await LocalFileService.instance.uploadFile(file, destination);
  }

  Future<void> deleteMenu() async {
    if (menu.id != null) {
      await LocalDatabase.instance
          .deleteDocument(_menuCollectionName, menu.id!);
    }
  }
}

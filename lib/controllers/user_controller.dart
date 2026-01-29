import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/controllers/enums/position_enum.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/employee_model.dart';
import 'package:cashier_app/views/pages/authentication/login_page.dart';
import 'package:cashier_app/views/pages/dashboard/dasboard.dart';
import 'package:cashier_app/services/local_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // static UserController get instance => Get.find();
  var userLoaded = false.obs;
  EmployeeModel userModel = EmployeeModel();
  final _collectionName = DocumentName.EMPLOYEE.name.toLowerCase();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void onReady() {
    // keep initialization simple for local storage: if there is a logged-in user, fetch it
    LocalDatabase.instance.getMeta('currentUser').then((meta) async {
      if (meta == null || meta['uid'] == null) {
        Get.offAll(() => const LoginPage());
      } else {
        await fetchUserData(meta['uid']);
        await addOrUpdateUser();
        Get.offAll(() => const MainDashboard());
      }
    });
    super.onReady();
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    // very small local auth: store email and password inside employee document (not encrypted)
    try {
      userModel.email = email;
      userModel.createdAt = DateTime.now();
      userModel.lastSignIn = DateTime.now();
      // store password field locally (field name: _password) so we can validate on login
      final data = userModel.copyWith().toJson();
      data['_password'] = password;
      final id =
          await LocalDatabase.instance.addDocument(_collectionName, data);
      userModel = EmployeeModel.fromJson(id, data);
    } catch (e) {
      log(e.toString(), error: "$runtimeType");
      rethrow;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final users = await LocalDatabase.instance
          .whereEquals(_collectionName, 'email', email);
      if (users.isEmpty) {
        log('No user found', error: '$runtimeType');
        return;
      }
      final user = users.first;
      if ((user['_password'] ?? '') == password) {
        final uid = user['id'];
        await LocalDatabase.instance.setMeta('currentUser', {'uid': uid});
        await fetchUserData(uid);
        await addOrUpdateUser();
        Get.offAll(() => const MainDashboard());
      } else {
        log('Invalid password', error: '$runtimeType');
      }
    } catch (e) {
      log(e.toString(), error: "$runtimeType");
    }
  }

  Future<void> logout() async {
    userModel = EmployeeModel();
    await LocalDatabase.instance.setMeta('currentUser', {});
  }

  void registerUser(String email, String password) {
    createUserWithEmailAndPassword(email, password);
  }

  void loginUser(String email, String password) {
    loginUserWithEmailAndPassword(email, password);
  }

  Future<void> fetchUserData(String uid) async {
    final users = await LocalDatabase.instance
        .whereEquals(_collectionName, 'firebaseUID', uid);
    if (users.isNotEmpty) {
      userModel = EmployeeModel.fromJson(users.first['id'], users.first);
    }
  }

  Future<void> addOrUpdateUser(
      {DateTime? lastLogin,
      String? merchantId,
      List<String>? locationId}) async {
    final now = DateTime.now();
    if (userModel.id != null) {
      final updated = userModel.copyWith(
          updatedAt: now,
          lastSignIn: lastLogin,
          employeeAt: merchantId,
          manageAt: locationId);
      await LocalDatabase.instance
          .updateDocument(_collectionName, userModel.id!, updated.toJson());
    } else {
      final data = userModel
          .copyWith(
              createdAt: now,
              employeeAt: merchantId,
              lastSignIn: now,
              manageAt: locationId,
              position: PositionEnum.OWNER,
              positionName: PositionEnum.OWNER.name,
              status: StatusEnum.ACTIVE,
              updatedAt: now)
          .toJson();
      final id =
          await LocalDatabase.instance.addDocument(_collectionName, data);
      userModel = EmployeeModel.fromJson(id, data);
      Get.offAll(() => const MainDashboard());
    }
  }
}

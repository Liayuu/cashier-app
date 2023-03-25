import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/models/employee_model.dart';
import 'package:cashier_app/views/pages/authentication/login_page.dart';
import 'package:cashier_app/views/pages/dashboard/dasboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // static UserController get instance => Get.find();
  var userLoaded = false.obs;
  EmployeeModel userModel = EmployeeModel();
  final _userControllerRef =
      FirebaseFirestore.instance.collection(DocumentName.EMPLOYEE.name.toLowerCase());

  final _auth = FirebaseAuth.instance;

  late Rx<User?> firebaseUser;

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      firebaseUser = Rx<User?>(_auth.currentUser);
      firebaseUser.bindStream(_auth.userChanges());
      ever(firebaseUser, _setInitialScreen);
    });
    super.onReady();
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      await fetchUserData(user.uid);
      Get.offAll(() => const MainDashboard());
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      log(e.code, error: "$runtimeType");
    }
  }

  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => _setInitialScreen(value.user));
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      log(e.code, error: "$runtimeType");
    }
  }

  Future<void> logout() async => await _auth.signOut();

  void registerUser(String email, String password) {
    createUserWithEmailAndPassword(email, password);
  }

  void loginUser(String email, String password) {
    loginUserWithEmailAndPassword(email, password);
  }

  Future<void> fetchUserData(String uid) async {
    await _userControllerRef
        .where('firebaseUID', isEqualTo: uid)
        .withConverter<EmployeeModel>(
          fromFirestore: (snapshot, options) =>
              EmployeeModel.fromJson(snapshot.id, snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .get()
        .then((value) {
      userModel = value.docs.first.data();
    });
  }
}

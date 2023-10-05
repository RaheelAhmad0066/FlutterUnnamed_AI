import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../GoogleAuth/Googleauth.dart';
import '../models/walkthrough1_model.dart';

class Walkthrough1Controller extends GetxController {
  Rx<Walkthrough1Model> walkthrough1ModelObj = Walkthrough1Model().obs;
}

class MyController extends GetxController {
  var isLoading = false.obs; // Using an observable for managing loading state.
  final googleauth = Get.put(AuthController());
  void startLoading(BuildContext context) {
    isLoading.value = true;
    // Simulate some async task (e.g., an API call)
    Future.delayed(Duration(seconds: 3), () async {
      isLoading.value = false;
      googleauth.handleSignInAndNavigateToHome(context);
    });
  }
}

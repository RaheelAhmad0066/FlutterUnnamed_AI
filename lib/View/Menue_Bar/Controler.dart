import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../page/HomePage.dart';
// import 'package:unamedai/View/home_page.dart';

class MenueLoader extends GetxController {
  var isLoading = false.obs; // Using an observable for managing loading state.
  var Loading = false.obs; // Using an observable for managing loading state.

  void Startnewchat(BuildContext context) {
    isLoading.value = true;
    // Simulate some async task (e.g., an API call)
    Future.delayed(Duration(seconds: 2), () async {
      isLoading.value = false;
      Get.to(HomePage());
    });
  }

  void clearchat(BuildContext context) {
    Loading.value = true;
    // Simulate some async task (e.g., an API call)
    Future.delayed(Duration(seconds: 2), () async {
      Loading.value = false;
      // Get.to(HomePage());
    });
  }
  // void Startnewchat(BuildContext context) {
  //   isLoading.value = true;
  //   // Simulate some async task (e.g., an API call)
  //   Future.delayed(Duration(seconds: 3), () async {
  //     isLoading.value = false;

  //   });
}

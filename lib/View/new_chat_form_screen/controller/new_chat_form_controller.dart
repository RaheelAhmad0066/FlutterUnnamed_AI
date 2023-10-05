import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class userdata extends GetxController {
  final colection = FirebaseFirestore.instance.collection('UserData');
  RxBool isloading = false.obs;
  // Using an observable for managing loading state.
  void homepage(BuildContext context) {
    isloading.value = true;
    // Simulate some async task (e.g., an API call)
    Future.delayed(Duration(seconds: 2), () async {
      isloading.value = false;
    });
  }
}

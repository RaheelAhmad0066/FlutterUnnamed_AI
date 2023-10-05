import 'dart:async';

import 'package:aichat/View/walkthrough1_screen/walkthrough1_screen.dart';
import 'package:aichat/core/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/utils/image_constant.dart';
import '../../page/HomePage.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/borderline.dart';

import 'package:flutter/material.dart';

import '../../widgets/custom_image_view.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  @override
  void initState() {
    // TODO: implement initState
    islogin();
    super.initState();
  }

  void islogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => HomePage())),
            (route) => false);
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => Walkthrough1Screen())),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 166.v),
                      CustomImageView(
                          svgPath: ImageConstant.imgVector,
                          height: 120.v,
                          width: 125.h),
                      SizedBox(
                        height: 400.h,
                      ),
                      Text("Unnamed Ai", style: theme.textTheme.headlineSmall),
                      SizedBox(
                        height: 20.h,
                      ),
                      borderline(
                        color: Colors.white,
                      ),
                    ]))));
  }
}

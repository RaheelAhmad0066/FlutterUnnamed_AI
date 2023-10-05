import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/borderline.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image_view.dart';
import 'controller/walkthrough1_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class Walkthrough1Screen extends GetWidget<Walkthrough1Controller> {
  Walkthrough1Screen({Key? key})
      : super(
          key: key,
        );
  final Isloading = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 161.v),
              CustomImageView(
                svgPath: ImageConstant.imgVector,
                height: 120.v,
                width: 125.h,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 29.h,
                ),
                decoration: AppDecoration.fillWhiteA.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderTL20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 19.v),
                    Text(
                      "Welcome to Unnamed Ai".tr,
                      style: theme.textTheme.headlineMedium,
                    ),
                    SizedBox(height: 7.v),
                    SizedBox(
                      width: 314.h,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Read our".tr,
                              style:
                                  CustomTextStyles.bodyLargePrimaryContainer16,
                            ),
                            TextSpan(
                              text: " Privacy Policy.",
                              style: CustomTextStyles.bodyLargeOnPrimary,
                            ),
                            TextSpan(
                              text: " Tap ”Get Started” to accept the",
                              style:
                                  CustomTextStyles.bodyLargePrimaryContainer16,
                            ),
                            TextSpan(
                              text: "Terms of Service.",
                              style: CustomTextStyles.bodyLargeOnPrimary,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Obx(
                      () => Isloading.isLoading.value
                          ? CircularProgressIndicator()
                          : CustomElevatedButton(
                              onTap: () async {
                                Isloading.startLoading(context);
                              },
                              text: "Google SignIn",
                            ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    borderline(
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import '../../core/utils/image_constant.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_text_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/menu_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:aichat/core/utils/size_utils.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class MenuHistoryScreen extends GetWidget<MenuHistoryController> {
  const MenuHistoryScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingWidth: 52.h,
          leading: AppbarImage(
            svgPath: ImageConstant.imgClock,
            margin: EdgeInsets.only(
              left: 20.h,
              top: 11.v,
              bottom: 12.v,
            ),
          ),
          title: AppbarTitle(
            text: "lbl_menu".tr,
            margin: EdgeInsets.only(left: 15.h),
          ),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 9.v),
          child: Column(
            children: [
              CustomElevatedButton(
                text: "lbl_start_new_chat".tr,
                isDisabled: true,
              ),
              SizedBox(height: 10.v),
              CustomOutlinedButton(
                text: "lbl_chat_history".tr,
              ),
              SizedBox(height: 10.v),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 13.v,
                ),
                decoration: AppDecoration.outlineBlueGray,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.v),
                            child: Text(
                              "lbl_today".tr,
                              style: CustomTextStyles.bodyLargeWhiteA70016,
                            ),
                          ),
                          CustomImageView(
                            svgPath: ImageConstant.imgSignal,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.v),
                    Text(
                      "msg_bowser_supermario".tr,
                      style: CustomTextStyles.bodyLargeWhiteA700,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.v),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 14.v,
                ),
                decoration: AppDecoration.outlineBlueGray,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 2.v),
                            child: Text(
                              "lbl_02_feb_2023".tr,
                              style: CustomTextStyles.bodyLargeWhiteA70016,
                            ),
                          ),
                          CustomImageView(
                            svgPath: ImageConstant.imgSignal,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.v),
                    Text(
                      "msg_ainame_usersname".tr,
                      style: CustomTextStyles.bodyLargeWhiteA700,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.h, 25.v, 20.h, 5.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 2.v),
                            child: Text(
                              "lbl_10_feb_2023".tr,
                              style: CustomTextStyles.bodyLargeWhiteA70016,
                            ),
                          ),
                          CustomImageView(
                            svgPath: ImageConstant.imgSignal,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.v),
                    Text(
                      "msg_ainame2_usersname2".tr,
                      style: CustomTextStyles.bodyLargeWhiteA700,
                    ),
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

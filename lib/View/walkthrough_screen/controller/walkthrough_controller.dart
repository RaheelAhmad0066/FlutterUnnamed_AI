import 'package:get/get.dart';

import '../models/walkthrough_model.dart';

/// A controller class for the WalkthroughScreen.
///
/// This class manages the state of the WalkthroughScreen, including the
/// current walkthroughModelObj
class WalkthroughController extends GetxController {
  Rx<WalkthroughModel> walkthroughModelObj = WalkthroughModel().obs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      // Get.offNamed(
      //   // AppRoutes.walkthrough1Screen,
      // );
    });
  }
}

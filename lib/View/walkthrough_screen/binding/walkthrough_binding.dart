import '../controller/walkthrough_controller.dart';
import 'package:get/get.dart';

/// A binding class for the WalkthroughScreen.
///
/// This class ensures that the WalkthroughController is created when the
/// WalkthroughScreen is first loaded.
class WalkthroughBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalkthroughController());
  }
}

import '../controller/menu_history_controller.dart';
import 'package:get/get.dart';

/// A binding class for the MenuHistoryScreen.
///
/// This class ensures that the MenuHistoryController is created when the
/// MenuHistoryScreen is first loaded.
class MenuHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MenuHistoryController());
  }
}

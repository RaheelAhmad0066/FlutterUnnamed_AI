import 'package:get/get.dart';

import '../models/menu_history_model.dart';

/// A controller class for the MenuHistoryScreen.
///
/// This class manages the state of the MenuHistoryScreen, including the
/// current menuHistoryModelObj
class MenuHistoryController extends GetxController {
  Rx<MenuHistoryModel> menuHistoryModelObj = MenuHistoryModel().obs;
}

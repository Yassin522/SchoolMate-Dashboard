import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:school_management_system/view/screens/grades/grades_api.dart';
import 'package:school_management_system/view/screens/main-screen/main-screen.dart';

class MainController extends GetxController {
  var index = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  updateIndex(int newIndex) {
    index.value = newIndex;
    update();
  }

  void controlMenu() {
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
}

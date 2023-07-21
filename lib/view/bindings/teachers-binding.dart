import 'package:get/get.dart';
import 'package:school_management_system/view/screens/login/login_controller.dart';
import 'package:school_management_system/view/screens/teachers/teachers-controller.dart';

class TeachersBinding implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => TeachersController());
  }
}
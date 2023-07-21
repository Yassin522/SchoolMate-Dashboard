import 'package:get/get.dart';
import 'package:school_management_system/view/screens/login/login_controller.dart';
import 'package:school_management_system/view/screens/schedules/schedules-controller.dart';

class SchedulesBinding implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => SchedulesController());
  }
}
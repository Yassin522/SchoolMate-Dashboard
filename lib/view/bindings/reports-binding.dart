import 'package:get/get.dart';
import 'package:school_management_system/view/screens/login/login_controller.dart';
import 'package:school_management_system/view/screens/reports/reports-controller.dart';

class ReportsBinding implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => ReportsAndEmailsController());
  }
}
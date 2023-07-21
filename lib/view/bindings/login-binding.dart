import 'package:get/get.dart';
import 'package:school_management_system/view/screens/login/login_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => LoginConroller());
  }
}
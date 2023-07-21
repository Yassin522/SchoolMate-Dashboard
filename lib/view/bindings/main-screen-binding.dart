import 'package:get/get.dart';
import 'package:school_management_system/view/screens/main-screen/main-controller.dart';
import 'package:school_management_system/view/screens/your-school/your_school_controller.dart';

class MainScreenBinding implements Bindings{
  @override
  void dependencies(){
Get.lazyPut(() => MainController());  }
}
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:school_management_system/view/screens/reports/reports_api.dart';

class ReportsAndEmailsController extends GetxController {
  RxBool isReports = true.obs;
  RxBool isEmails = false.obs;

  var isDeleting = false.obs;
  var myreporst = [].obs;

  @override
  void onInit() async {
    getmyReports();
  }

  getmyReports() async {
    print('getting new Reports ...');
    myreporst.value = await ReportApi.getReports();
    print(myreporst.value);
    print('Done!');
  }

  void deleting() {
    this.isDeleting.value = !isDeleting.value;
    update();
  }

  void selectReports() {
    isReports.value = true;
    isEmails.value = false;
    update();
  }

  void selectEmails() {
    isReports.value = false;
    isEmails.value = true;
    update();
  }

//reset the values
  void resetValues() {
    isReports = true.obs;
    isEmails = false.obs;
    update();
  }
}

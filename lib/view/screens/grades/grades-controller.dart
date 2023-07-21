import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'grades_api.dart';

class GradesController extends GetxController {
  GradeApi gradeapi = GradeApi();
  var mygrades = [].obs;
  final gradeNameController = TextEditingController();
  final gradeFeesController = TextEditingController();
  var gradesOptions = <String>[].obs;
  var selectedGradesOptionList = <String>[].obs;
  var selectedGradesOption = ''.obs;
  List<String> subjectsOptions = <String>[].obs;
  var selectedSubjectsOptionList = <String>[].obs;
  var selectedSubjectsOption = ''.obs;

  @override
  void onInit() {
    getmyGrades();
    getSubjectOptions();
    getgradesOptions();
  }

  getmyGrades() async {
    print('getting grades ...');
    mygrades.value = await gradeapi.getGrades();
    print('Done!');
  }

  getgradesOptions() async {
    print('getting grades options...');
    gradesOptions.value = await GradeApi.getGradesOptions();
    print('Done!');
    update();
  }

  updateUiAfterAdd() {
    print('========================');
    print('Ui update called');
    update();
  }

  deletegrade(var name) async {
    await GradeApi.deleteGrade(name);
  }

  addgrade() async {
    //Get.back();
    await GradeApi.addgradeapi(gradeNameController.text,
        gradeFeesController.text, selectedSubjectsOptionList.value);
    update();
  }

  getSubjectOptions() async {
    subjectsOptions = await GradeApi.getMySubjects(gradeNameController.text);
    update();
  }
}

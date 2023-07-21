import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:school_management_system/view/screens/classes/classes_api.dart';
import 'package:school_management_system/view/screens/grades/grades-controller.dart';
import 'package:school_management_system/view/screens/grades/grades_api.dart';

class ClassesController extends GetxController {
  var myclasses = [].obs;
  RxBool ok = true.obs;

  
  var gradesOptions = <String>[].obs;
  var selectedGradesOptionList = <String>[].obs;
  var selectedGradesOption = 'Grade'.obs;

  GradeApi gradeapi = GradeApi();
  var mygrades = [].obs;
  final gradeNameController = TextEditingController();
  final gradeFeesController = TextEditingController();

  final AcadimicyearController = TextEditingController();
  final SectionController = TextEditingController();
  var myteachers = [].obs;
  var teachersOptions = <String>[].obs;

  var selectedTeachersOptionList = <String>[].obs;
  var selectedTeachersOption = 'Teachers'.obs;

  var items = <String>[].obs;
  var dropdownvalue = 'Grade'.obs;

  @override
  void onInit() async {
    getmyClasses();
    getgradesOptions();
    getteachersOptions();
  }

  List<String> classesoptions = ['1', '2', '3'];
  var selectedClassesOptionList = [''].obs;
  var selectedClassesOption = ''.obs;

  var isDeleting = false.obs;
  void deleting() {
    this.isDeleting.value = !isDeleting.value;
    update();
  }

  changevalue(String? val) {
    dropdownvalue.value = val!;
    update();
  }

  addclass() async {
    //Get.back();
    print('add class...');
    await ClassesApi.addclassapi(dropdownvalue.value, SectionController.text,
        selectedTeachersOptionList.value);
    print('Done!');
    update();
  }

  getteachersOptions() async {
    print('getting teachers options...');
    teachersOptions.value = await ClassesApi.getTeachersOptions();
    print('Done!');
    update();
  }

  getgradesOptions() async {
    print('getting grades options...');
    gradesOptions.value = await GradeApi.getGradesOptions();
    items.value = await GradeApi.getGradesOptions();
    dropdownvalue.value = items[0];
    print(items.value);
    print('Done!');
    update();
  }

  getmyClasses() async {
    if (ok.value) {
      print('getting Classes ...');
      myclasses.value = await ClassesApi.getClasses();
      print('Done!');
    } else {
      print('getting new Classes ...');
      myclasses.value =
          await ClassesApi.getNewClasses(selectedGradesOptionList.value);
      print(myclasses.value);
      print('Done!');
    }
  }

  getnewClasses(List<String> segrades) async {
    print('getting new Classes ...');
    myclasses.value =
        await ClassesApi.getNewClasses(selectedGradesOptionList.value);
    print(myclasses.value);
    print('Done!');
    update();
  }

  deletegrade(var name) async {
    await ClassesApi.deleteGrade(name);
  }
}

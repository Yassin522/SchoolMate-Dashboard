import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:school_management_system/view/screens/announcements/announcememtsapi.dart';
import 'package:school_management_system/view/screens/classes/classes_api.dart';
import 'package:school_management_system/view/screens/grades/grades_api.dart';
import 'package:school_management_system/view/screens/subjects/subject_api.dart';

class SubjectsController extends GetxController {
  var mysubjects = [].obs;
  RxBool ok = true.obs;
  var gradesOptions = <String>[].obs;
  var selectedGradesOptionList = <String>[].obs;
  var selectedGradesOption = 'Grade'.obs;

  var mygrades = [].obs;
  final gradeNameController = TextEditingController();
  final gradeFeesController = TextEditingController();

  var items = <String>[].obs;
  var dropdownvalue = 'Grade'.obs;
  final subjectNameController = TextEditingController();

  var myteachers = [].obs;
  var teachersOptions = <String>[].obs;
  var selectedTeachersOptionList = <String>[].obs;
  var selectedTeachersOption = 'Teachers'.obs;

  var items2 = <String>[].obs;
  var dropdownvalue2 = 'Teacher'.obs;

  var items3 = <String>[].obs;
  var dropdownvalue3 = 'Class'.obs;

  var myclasses = [].obs;
  var classesOptions = <String>[].obs;
  var selectedclassesOptionList = <String>[].obs;
  var selectedclassesOption = 'Teachers'.obs;

  @override
  void onInit() async {
    getgradesOptions();
    getteachersOptions2();
    getmySubjects();
    getteachersOptions();
  }

  getclassOptions(String? grade) async {
    print('getting classes options...');
    classesOptions.value = await SubjectApi.getClassroomOptions(grade);
    print('Done!');
    update();
  }



  addSubject() async {
    //Get.back();
    print('add subject...');
    await SubjectApi.addsubjectapi(dropdownvalue.value,
        subjectNameController.text, selectedTeachersOptionList.value);
    print('Done!');
    update();
  }

   getteachersOptions2() async {
    print('getting teachers options...');
    teachersOptions.value = await ClassesApi.getTeachersOptions();
    print('Done!');
    update();
  }

  getteachersOptions() async {
    print('getting teachers options...');
    items2.value = await await ClassesApi.getTeachersOptions();
    dropdownvalue2.value = items2[0];
    print('Done!');
    update();
  }

  changevalue(String? val) {
    dropdownvalue.value = val!;
    update();
  }

  changevalue2(String? val) {
    dropdownvalue2.value = val!;
     update();
  }

  getgradesOptions() async {
    print('getting grades options...');
    gradesOptions.value = await SubjectApi.getGradesOptions();
    items.value = await GradeApi.getGradesOptions();
    dropdownvalue.value = items[0];
    print(items.value);
    print('Done!');
    update();
  }

  getmySubjects() async {
    if (ok.value) {
      print('getting Subjects ...');
      mysubjects.value = await SubjectApi.getSubjects();
      print('Done!');
    } else {
      print('getting new Subjects ...');
      mysubjects.value =
          await SubjectApi.getNewSubjects(selectedGradesOptionList.value);
      print(mysubjects.value);
      print('Done!');
    }
  }

  getnewSubjects(List<String> segrades) async {
    print('getting new Subjects ...');
    mysubjects.value =
        await SubjectApi.getNewSubjects(selectedGradesOptionList.value);
    print(mysubjects.value);
    print('Done!');
    update();
  }
}

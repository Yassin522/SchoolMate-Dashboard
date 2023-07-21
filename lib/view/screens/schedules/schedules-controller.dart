import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:school_management_system/view/screens/schedules/schedulesapi.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';

import '../classes/classes_api.dart';
import '../grades/grades_api.dart';
import '../subjects/subject_api.dart';

class SchedulesController extends GetxController {
  RxBool isTeacher = true.obs;
  RxBool isStudent = false.obs;
  var fileurl = 'nothing'.obs;

  var myclassroom = [].obs;
  var classroomOptions = <String>[].obs;
  var selectedclassroomOptionList = <String>[].obs;
  var selectedclassroomOption = ''.obs;

  var Weeklylist = [].obs;
  var Examlist = [].obs;

  var items = ['Teacher', 'classroom'];
  var dropdownvalue = 'Teacher'.obs;

  var items3 = ['exam', 'weekly'];
  var dropdownvalue3 = 'exam'.obs;

  var items2 = <String>[].obs;
  var dropdownvalue2 = ''.obs;

  var items4 = <String>[].obs;
  var dropdownvalue4 = ''.obs;

  var items5 = <String>[].obs;
  var dropdownvalue5 = ''.obs;

  GradeApi gradeapi = GradeApi();
  var mygrades = [].obs;
  final gradeNameController = TextEditingController();
  final gradeFeesController = TextEditingController();

  var gradesOptions = <String>[].obs;
  var selectedGradesOptionList = <String>[].obs;
  var selectedGradesOption = 'Grade'.obs;

  var myteachers = [].obs;
  var teachersOptions = <String>[].obs;
  var selectedTeachersOptionList = <String>[].obs;
  var selectedTeachersOption = 'Teachers'.obs;

  var classesOptions = <String>[].obs;
  var selectedclassesOptionList = <String>[].obs;
  var selectedclassesOption = 'Teachers'.obs;

  @override
  void onInit() async {
    getclassOptions(dropdownvalue4.value);
    getmyWeeklySchedules();
    getmyExamSchedules();
    getgradesOptions();
    getteachersOptions();
  }

  
deleteSchedule(String? id, String? classroom) async {
    await SchedulesApi.deleteschedule(id,classroom);
    getmyWeeklySchedules();
    getmyExamSchedules();
    getgradesOptions();
    getteachersOptions();
    update();
  }
  getclassOptions2(String? grade) async {
    print('getting classes options...');
    classesOptions.value = await SubjectApi.getClassroomOptions(grade);
    print('Done!');
  }

  addteacher(String teacher, List<String> selclasses, String? grade, String? id,
      String? name) async {
    print('adding teacher...');
    await SchedulesApi.addingteacher(teacher, selclasses, grade, id, name);
    print('Done!');
  }

  addSchedule() async {
    print('add Schedule...');
    EasyLoading.show(
      status: 'loading...',
      dismissOnTap: true,
    );
    await SchedulesApi.addNewSchedule(
        dropdownvalue.value,
        dropdownvalue3.value,
        dropdownvalue4.value,
        dropdownvalue2.value,
        dropdownvalue5.value,
        fileurl.value);
    print('Done!');
    EasyLoading.showSuccess('Great Success!');
    fileurl.value = 'nothing';
    update();
  }

  getteachersOptions() async {
    print('getting teachers options...');
    teachersOptions.value = await ClassesApi.getTeachersOptions();
    items5.value = await await ClassesApi.getTeachersOptions();
    dropdownvalue5.value = items5[0];
    print(items4.value);
    print('Done!');
    update();
  }

  getgradesOptions() async {
    print('getting grades options...');
    gradesOptions.value = await GradeApi.getGradesOptions();
    items4.value = await GradeApi.getGradesOptions();
    dropdownvalue4.value = items4[0];
    print(items4.value);
    print('Done!');
    update();
  }

  getclassOptions(String dropdownvalue4) async {
    print('getting classes options...');
    print(dropdownvalue4);
    classroomOptions.value =
        await SchedulesApi.getClassroomOptions(dropdownvalue4);
    items2.value = await SchedulesApi.getClassroomOptions(dropdownvalue4);
    if (items2.value.isEmpty) {
    } else {
      dropdownvalue2.value = items2[0];
    }
    print('Done!');
    update();
  }

  getmyWeeklySchedules() async {
    print('getting new isTeacher ...');
    Weeklylist.value = await SchedulesApi.getmyWeekly();
    print(Weeklylist.value);
    print('Done!');
  }

  getmyExamSchedules() async {
    print('getting new isStudent ...');
    Examlist.value = await SchedulesApi.getmyExam();
    print(Examlist.value);
    print('Done!');
    update();
  }

  void selectWeekly() {
    isTeacher.value = true;
    isStudent.value = false;
    update();
  }

  void selectExam() {
    isTeacher.value = false;
    isStudent.value = true;
    update();
  }

  //reset the values
  void resetValues() {
    isTeacher = true.obs;
    isStudent = false.obs;
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

  changevalue3(String? val) {
    dropdownvalue3.value = val!;
    update();
  }

  changevalue4(String? val) {
    dropdownvalue4.value = val!;
    update();
  }

  changevalue5(String? val) {
    dropdownvalue5.value = val!;
    update();
  }
}

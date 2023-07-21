import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:school_management_system/view/screens/students/studentsApi.dart';

import '../../../models/student.dart';
import '../grades/grades_api.dart';
import '../schedules/schedulesapi.dart';

class StudentsController extends GetxController {
  var firstnamecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phoneNumberController = TextEditingController();
  var fathernamecontroller = TextEditingController();
  var mothercontroller = TextEditingController();
  var parentphonecontroller = TextEditingController();
  var parentsemailcontroller = TextEditingController();
  var paidFeecontroller = TextEditingController();
  var leftFeecontroller = TextEditingController();
  var additionalInforamtionController = TextEditingController();
  var searchController = TextEditingController();

  var isAdding = false.obs;
  var isDeleting = false.obs;
  var isEditing = false.obs;
  var showInfo = false.obs;
  final gradeNameController = TextEditingController();
  Student? studentInfo;
  var mystudents = [].obs;
//     var isExist=true.obs;

// void takeExistingValue(var newValue)
// {
//   isExist.value=newValue;
//   update();
// }
// void check(){isExist.value=!isExist.value;update();}
  var selectedGrade = "Grade".obs;
  final selectGradeOptions = ['1', '2', '3'].obs;

  var selectedClass = "Class".obs;
  final selectClassOptions = ['A', 'B', 'C'].obs;

  var selectedClass2 = "Class".obs;
  final selectClassOptions2 = ['Nothing'].obs;

  var selectedGrade2 = "Grade".obs;
  final selectGradeOptions2 = ['Nothing'].obs;

  @override
  void onInit() {
    getmyStudents();
    getgradesOptions();
  }

  addStudent() async {
    print('adding student...');
    EasyLoading.show(
      status: 'loading...',
      dismissOnTap: true,
    );
    await StudentApi.addingStudent(
      firstnamecontroller.text,
      lastnamecontroller.text,
      emailcontroller.text,
      phoneNumberController.text,
      fathernamecontroller.text,
      mothercontroller.text,
      parentphonecontroller.text,
      parentsemailcontroller.text,
      paidFeecontroller.text,
      selectedGrade.value,
      selectedClass.value,
      additionalInforamtionController.text,
    );
    print('Done!');
    EasyLoading.showSuccess('Great Success!');
    update();
  }

  getNewStudents() async {
    print('getting New students ...');
    mystudents.value = await StudentApi.getNewStudents(
        selectedGrade2.value, selectedClass2.value);
    print('Done!');
    update();
  }

    getSearchStudents() async {
    print('getting New students ...');
    mystudents.value = await StudentApi.getsearchStudents(searchController.text
        );
    print('Done!');
    update();
  }

  getgradesOptions() async {
    print('getting grades options...');
    selectGradeOptions.value = await GradeApi.getGradesOptions();
    selectGradeOptions2.value = await GradeApi.getGradesOptions();
    print('Done!');
    update();
  }

  getclassOptions(selectedGrade) async {
    print('getting classes options...');
    print(selectedGrade);
    selectClassOptions.value =
        await SchedulesApi.getClassroomOptions(selectedGrade.value);

    print('Done!');
    update();
  }

  getclassOptions2(selectedGrade2) async {
    print('getting classes options...');
    print(selectedGrade2);
    selectClassOptions2.value =
        await SchedulesApi.getClassroomOptions(selectedGrade2.value);

    print('Done!');
    update();
  }

  getmyStudents() async {
    print('getting students ...');
    mystudents.value = await StudentApi.getStudents(searchController.text);
    print('Done!');
  }

  void uploadStudent(Student student) {
    this.studentInfo = student;
  }

  void uploadStudentInformation() {
    firstnamecontroller = TextEditingController()
      ..text = studentInfo!.firstName;
    lastnamecontroller = TextEditingController()..text = studentInfo!.lastName;
    emailcontroller = TextEditingController()..text = studentInfo!.email;
    phoneNumberController = TextEditingController()..text = studentInfo!.phone!;
    fathernamecontroller = TextEditingController()
      ..text = studentInfo!.fatherName!;
    mothercontroller = TextEditingController()..text = studentInfo!.motherName!;
    parentphonecontroller = TextEditingController()
      ..text = studentInfo!.parentPhone!;
    parentsemailcontroller = TextEditingController()
      ..text = studentInfo!.parentEmail!;
    paidFeecontroller = TextEditingController()..text = studentInfo!.fees!;
    leftFeecontroller = TextEditingController()..text = studentInfo!.fees!;
    additionalInforamtionController = TextEditingController()
      ..text = studentInfo!.additional!;

    selectedGrade.value = studentInfo!.studentGrade!;
    selectedClass.value = studentInfo!.studentClass!;
  }

  void stopUploadingInfo() {
    firstnamecontroller.clear();
    lastnamecontroller.clear();
    emailcontroller.clear();
    phoneNumberController.clear();
    fathernamecontroller.clear();
    mothercontroller.clear();
    parentphonecontroller.clear();
    parentsemailcontroller.clear();
    paidFeecontroller.clear();
    leftFeecontroller.clear();
    additionalInforamtionController.clear();
  }

  void deleting() {
    this.isDeleting.value = !isDeleting.value;
    update();
  }

  void activeAddingStudent() {
    this.isAdding.value = true;
    update();
  }

  void unactiveAddingStudent() {
    this.isAdding.value = false;
    update();
  }

  void enableEditing() {
    this.isEditing.value = true;
    selectedGrade.value = 'Grade';
    selectedClass.value = 'Class';
    update();
  }

  void disableEditing() {
    this.isEditing.value = false;
    update();
  }

  void showInformation() {
    this.showInfo.value = true;
  }

  void unShowInformation() {
    this.showInfo.value = false;
  }

  void setSelectedGrade(value) {
    selectedGrade.value = value;
    getclassOptions(selectedGrade);
    update();
  }

  void setSelectedClass(value) {
    selectedClass.value = value;
    update();
  }

  void setSelectedGrade2(value) {
    selectedGrade2.value = value;
    print('xddddddddddd');
    getclassOptions2(selectedGrade2);
    update();
  }

  void setSelectedClass2(value) {
    selectedClass2.value = value;
    update();
  }
}

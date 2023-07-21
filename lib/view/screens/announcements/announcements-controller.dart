import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/view/screens/main-screen/main-screen.dart';

import '../grades/grades_api.dart';
import '../schedules/schedulesapi.dart';
import 'announcememtsapi.dart';

class AnnouncementsController extends GetxController {
  RxBool isPublic = true.obs;
  RxBool isStudents = false.obs;
  RxBool isTeachers = false.obs;

  var myclassroom = [].obs;
  var classroomOptions = <String>[].obs;
  var selectedclassroomOptionList = <String>[].obs;
  var selectedclassroomOption = ''.obs;
  var publiclist = [].obs;
  var studentslist = [].obs;
  var teacherslist = [].obs;

  final ContentController = TextEditingController();
  final TitleController = TextEditingController();

  var items = ['All', 'Teachers', 'classroom'];
  var dropdownvalue = 'All'.obs;

  var items2 = <String>[].obs;
  var dropdownvalue2 = ''.obs;

  var gradesOptions = <String>[].obs;
  var selectedGradesOptionList = <String>[].obs;
  var selectedGradesOption = 'Grade'.obs;

  var items4 = <String>[].obs;
  var dropdownvalue4 = ''.obs;

  @override
  void onInit() async {
    getmyAnnouncements();
    getmyAnnouncementsTe();
    getmyAnnouncementsSt();
    getclassOptions(dropdownvalue4.value);
    getgradesOptions();
  }

  deleteAnnouncement(String? id) async {
    await AnnouncememtsApi.deleteannouncement(id);
    getmyAnnouncements();
    getmyAnnouncementsTe();
    getmyAnnouncementsSt();
    controller.update();
  }

  addAnnouncement() async {
    //Get.back();
    print('add Announcement...');
    await AnnouncememtsApi.addAnnouncememtapi(
        dropdownvalue.value,
        ContentController.text,
        TitleController.text,
        dropdownvalue2.value,
        dropdownvalue4.value);
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

  changevalue4(String? val) {
    dropdownvalue4.value = val!;
    update();
  }

  getnewAnnouncements(List<String> seclasses) async {
    print('getting new Announcements ...');
    studentslist.value = await AnnouncememtsApi.getNewAnnouncements(
        selectedclassroomOptionList.value);
    print(studentslist.value);
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

  getmyAnnouncements() async {
    print('getting new Announcements ...');
    publiclist.value = await AnnouncememtsApi.getAnnouncements();
    print(publiclist.value);
    print('Done!');
  }

  getmyAnnouncementsTe() async {
    print('getting new TAnnouncements ...');
    teacherslist.value = await AnnouncememtsApi.getTeachersAnnouncements();
    print(teacherslist.value);
    print('Done!');
    update();
  }

  getmyAnnouncementsSt() async {
    print('getting new SAnnouncements ...');
    studentslist.value = await AnnouncememtsApi.getStudentsAnnouncements();
    print(studentslist.value);
    print('Done!');
    update();
  }

  void selectPublicAnnouncements() {
    isPublic.value = true;
    isStudents.value = false;
    isTeachers.value = false;
    update();
  }

  void selectStudentsAnnouncements() {
    isPublic.value = false;
    isStudents.value = true;
    isTeachers.value = false;
    getmyAnnouncementsSt();
    update();
  }

  void selectTeachersAnnouncements() {
    isPublic.value = false;
    isStudents.value = false;
    isTeachers.value = true;
    getmyAnnouncementsTe();

    update();
  }

//reset the values
  void resetValues() {
    isPublic = true.obs;
    isStudents = false.obs;
    isTeachers = false.obs;
    update();
  }
}

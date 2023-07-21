import 'package:get/get.dart';
import 'package:school_management_system/view/bindings/announcements-binding.dart';
import 'package:school_management_system/view/bindings/classes-binding.dart';
import 'package:school_management_system/view/bindings/grades-binding.dart';
import 'package:school_management_system/view/bindings/login-binding.dart';
import 'package:school_management_system/view/bindings/main-screen-binding.dart';
import 'package:school_management_system/view/bindings/reports-binding.dart';
import 'package:school_management_system/view/bindings/schedules-binding.dart';
import 'package:school_management_system/view/bindings/students-binding.dart';
import 'package:school_management_system/view/bindings/subjects-binding.dart';
import 'package:school_management_system/view/bindings/teachers-binding.dart';
import 'package:school_management_system/view/bindings/your-school-binding.dart';
import 'package:school_management_system/view/screens/announcements/announcememts-screen.dart';
import 'package:school_management_system/view/screens/classes/classes-screen.dart';
import 'package:school_management_system/view/screens/grades/grades-screen.dart';
import 'package:school_management_system/view/screens/reports/reports-screen.dart';
import 'package:school_management_system/view/screens/schedules/schedules-screen.dart';
import 'package:school_management_system/view/screens/students/students-screen.dart';
import 'package:school_management_system/view/screens/subjects/subjects-screen.dart';
import 'package:school_management_system/view/screens/teachers/teachers-screen.dart';

import '../screens/login/login_screen.dart';
import '../screens/main-screen/main-screen.dart';
import '../screens/your-school/your-school-screen.dart';

class AppPages {
  AppPages._();
  static const login = '/login';
  static const yourSchool = '/your-school';
  static const mainScreen = '/main-screen';
  static const gradesScreen = '/grades-screen';
  static const classesScreen = '/classes-screen';
  static const subjectsScreen = '/subjects-screen';
  static const announcementsScreen = '/announcements-screen';
  static const reportsScreen = '/reports-screen';
  static const schedulesScreen = '/schedules-screen';
  static const studentsScreen = '/students-screen';
  static const teachersScreen = '/teachers-screen';

  static final pages = [
    GetPage(name: login, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: yourSchool,
        page: () => YourSchoolScreen(),
        binding: YourSchoolBinding()),
    GetPage(
        name: mainScreen,
        page: () => MainScreen(),
        binding: MainScreenBinding()),
   
  ];
}

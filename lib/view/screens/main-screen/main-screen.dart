import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/view/screens/announcements/announcememts-screen.dart';
import 'package:school_management_system/view/screens/classes/classes-screen.dart';
import 'package:school_management_system/view/screens/grades/grades-screen.dart';
import 'package:school_management_system/view/screens/main-screen/main-controller.dart';
import 'package:school_management_system/view/screens/reports/reports-screen.dart';
import 'package:school_management_system/view/screens/schedules/schedules-screen.dart';
import 'package:school_management_system/view/screens/students/add_student_screen.dart';
import 'package:school_management_system/view/screens/students/students-screen.dart';
import 'package:school_management_system/view/screens/subjects/subjects-screen.dart';
import 'package:school_management_system/view/screens/teachers/teachers-screen.dart';
import 'package:school_management_system/view/screens/your-school/your-school-screen.dart';
import 'package:school_management_system/view/utils/constants/responsive.dart';
import 'package:school_management_system/view/utils/navigation_controller.dart';

import '../../utils/widgets/menu.dart';

MainController controller = Get.put(MainController());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List _pages = [
      YourSchoolScreen(),
      GradesScreen(),
      ClassesScreen(),
      SubjectsScreen(),
      StudentsScreen(),
      TeachersScreen(),
      SchedulesScreen(),
      AnnouncementsScreen(),
      ReportsAndEmailsScreen(),
    ];
    
    return Scaffold(
      key: navigationController.scaffoldKey,
      drawer: menu(
        size: size,
      ),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
                child: menu(
              size: size,
            )),
          GetBuilder(init:MainController(),builder: (MainController navigationController){
            return Expanded(
              flex: 4, child: _pages[navigationController.index.value]);})
        ],
      )),
    );
  }
}

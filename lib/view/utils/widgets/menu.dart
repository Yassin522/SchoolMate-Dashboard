import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/view/screens/main-screen/main-controller.dart';
import 'package:school_management_system/view/screens/main-screen/main-screen.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';

import '../constants/constant.dart';
import '../constants/my_icons.dart';
import '../navigation_controller.dart';
import 'drawer-list-item.dart';

MainController navigationController = Get.put(MainController());

class menu extends StatelessWidget {
  menu({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradientColor,
        image: DecorationImage(
            image: AssetImage(controlBackground), fit: BoxFit.cover),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                  child: Padding(
                padding: EdgeInsets.only(top: defaultPadding * 3),
                child: Text(
                  'SchoolMate',
                  style: redHatBoldStyle(color: white, fontSize: 32),
                ),
              )),
              Column(children: [
                DarwerListItem(
                    title: 'Your School',
                    icon: MyIcons.school,
                    press: () {
                      navigationController.updateIndex(0);
                      navigationController.closeDrawer();
                    }),
                DarwerListItem(
                    title: 'Grades',
                    icon: MyIcons.grade,
                    press: () {
                      navigationController.updateIndex(1);
                      navigationController.closeDrawer();
                    }),
                DarwerListItem(
                    title: 'Classes',
                    icon: MyIcons.class_icon,
                    press: () {
                      navigationController.updateIndex(2);

                      navigationController.closeDrawer();
                    }),
                DarwerListItem(
                    title: 'Subjects',
                    icon: MyIcons.subject,
                    press: () {
                      navigationController.updateIndex(3);

                      navigationController.closeDrawer();
                    }),
                DarwerListItem(
                    title: 'Students',
                    icon: MyIcons.student,
                    press: () {
                      navigationController.updateIndex(4);
                      navigationController.closeDrawer();
                    }),
                DarwerListItem(
                    title: 'Teachers',
                    icon: MyIcons.student,
                    press: () {
                      navigationController.updateIndex(5);
                      navigationController.closeDrawer();
                    }),
                DarwerListItem(
                    title: 'Schedules',
                    icon: MyIcons.schedule,
                    press: () {
                      navigationController.updateIndex(6);
                      navigationController.closeDrawer();
                    }),
                DarwerListItem(
                    title: 'Announcements',
                    icon: MyIcons.announcements,
                    press: () {
                      navigationController.updateIndex(7);
                      navigationController.closeDrawer();
                    }),
                DarwerListItem(
                    title: 'Reports',
                    icon: MyIcons.reports,
                    press: () {
                      navigationController.updateIndex(8);
                      navigationController.closeDrawer();
                    }),
                SizedBox(height: size.height / 15),
                DarwerListItem(
                    title: 'Contact Us', icon: MyIcons.contact_us, press: () {})
              ])
            ],
          ),
        ),
      ),
    );
  }
}

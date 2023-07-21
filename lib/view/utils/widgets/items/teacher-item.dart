import 'package:flutter/material.dart';
import 'package:school_management_system/models/grades.dart';
import 'package:school_management_system/models/teacher.dart';
import 'package:school_management_system/view/screens/teachers/teachers-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/constants/my_icons.dart';
import 'package:school_management_system/view/utils/constants/responsive.dart';

class TeacherItem extends StatelessWidget {
  TeacherItem({required this.teacher, required this.controller});

  Teacher teacher;
  TeachersController controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.activeAddingTeacher();
        controller.showInformation();
        controller.uploadTeacher(teacher);
        controller.uploadTeacherInformation();
      },
      child: Container(
        decoration: myDecoration,
        child: Padding(
          padding: EdgeInsets.all(Responsive.isMobile(context)
              ? defaultPadding / 2
              : defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Responsive.isDesktop(context)
                    ? 250
                    : Responsive.isTablet(context)
                        ? 200
                        : 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    '${teacher.firstName! + ' ' + teacher.lastName!}',
                    style: redHatMediumStyle(
                        color: white,
                        fontSize: Responsive.isDesktop(context)
                            ? 28
                            : Responsive.isTablet(context)
                                ? 24
                                : 20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: Responsive.isDesktop(context) ? 52 : 32,
                  ),
                  Container(
                    width: Responsive.isDesktop(context) ? 150 : 100,
                    child: Text('${teacher.study.toString()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: redHatRegularStyle(
                            color: white,
                            fontSize: Responsive.isDesktop(context) ? 16 : 12)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

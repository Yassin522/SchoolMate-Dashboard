import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:school_management_system/models/teacher.dart';
import 'package:school_management_system/view/screens/teachers/add_teacher_screen.dart';
import 'package:school_management_system/view/screens/teachers/teachers-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/widgets/add-button.dart';
import 'package:school_management_system/view/utils/widgets/delete-button.dart';
import 'package:school_management_system/view/utils/widgets/items/teacher-item.dart';
import '../../utils/constants/responsive.dart';
import '../../utils/widgets/header.dart';
import '../classes/classes-controller.dart';
import '../grades/grades-controller.dart';

class TeachersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var textcontroller = TextEditingController();
    return SafeArea(
      child: GetBuilder(
          init: TeachersController(),
          builder: (TeachersController teachersController) {
            return !teachersController.isAdding.value
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: Responsive.isDesktop(context)
                                  ? defaultPadding * 3
                                  : Responsive.isTablet(context)
                                      ? defaultPadding * 2
                                      : defaultPadding,
                            ),
                            child: Header(
                              text: 'Teachers',
                              size: size,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                SizedBox(
                                  height: 500,
                                  width: Responsive.isDesktop(context)
                                      ? size.width / 3
                                      : size.width / 2,
                                  child: GetBuilder(
                                      init: TeachersController(),
                                      builder: (TeachersController c) {
                                        return FutureBuilder(
                                            future: c.getmyTeachers(),
                                            builder: ((context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child: Text('Loading...'));
                                              }

                                              return c.myteachers.isEmpty
                                                  ? SizedBox(
                                                      height: 500,
                                                      child: Center(
                                                        child: Text(
                                                          'NO Teachers',
                                                          style:
                                                              redHatBoldStyle(
                                                                  color:
                                                                      lightGray,
                                                                  fontSize: Responsive
                                                                          .isDesktop(
                                                                              context)
                                                                      ? 52
                                                                      : Responsive.isTablet(
                                                                              context)
                                                                          ? 40
                                                                          : 32),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: 500,
                                                      width:
                                                          Responsive.isDesktop(
                                                                  context)
                                                              ? size.width / 3
                                                              : size.width / 2,
                                                      child: ListView.separated(
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                SizedBox(
                                                          height: 32,
                                                        ),
                                                        itemCount: c.myteachers
                                                            .value.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return TeacherItem(
                                                            teacher: c
                                                                .myteachers
                                                                .value[index],
                                                            controller:
                                                                teachersController,
                                                          );
                                                        },
                                                      ),
                                                    );
                                            }));
                                      }),
                                ),
                              ]),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Responsive.isDesktop(context)
                                        ? 80
                                        : Responsive.isTablet(context)
                                            ? 40
                                            : 1),
                                child: Column(
                                  children: [
                                    AddButton(
                                        press: () {
                                          teachersController
                                              .activeAddingTeacher();
                                        },
                                        text: 'Add Teacher +'),
                                    SizedBox(
                                      height: Responsive.isDesktop(context)
                                          ? 28
                                          : 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : AddTeacherScreen(controller: teachersController);
          }),
    );
  }
}

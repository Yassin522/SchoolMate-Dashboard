import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:school_management_system/models/student.dart';
import 'package:school_management_system/view/screens/classes/classes-controller.dart';
import 'package:school_management_system/view/screens/students/students-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/widgets/add-button.dart';
import 'package:school_management_system/view/utils/widgets/delete-button.dart';
import 'package:school_management_system/view/utils/widgets/items/student-item.dart';
import 'package:expandable_search_bar/expandable_search_bar.dart';
import '../../utils/constants/responsive.dart';
import '../../utils/widgets/header.dart';
import '../../utils/widgets/select-menu.dart';
import '../grades/grades-controller.dart';
import 'add_student_screen.dart';

class StudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var textcontroller = TextEditingController();
    return SafeArea(
      child: GetBuilder(
          init: StudentsController(),
          builder: (StudentsController studentsController) {
            return !studentsController.isAdding.value
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          Row(
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
                                  text: 'Students',
                                  size: size,
                                ),
                              ),
                              SizedBox(width: 30),
                              Padding(
                                padding: const EdgeInsets.only(top: 45),
                                child: ExpandableSearchBar(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: 4,
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  width: 300,
                                  iconBackgroundColor: purple,
                                  iconColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  onTap: () {
                                    print(
                                      studentsController.searchController.text
                                          .toString(),
                                    );
                                    studentsController.getmyStudents();
                                    studentsController.refresh();
                                  },
                                  hintText: "Enter first name",
                                  editTextController:
                                      studentsController.searchController,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                /* GetBuilder(
                                    init: StudentsController(),
                                    builder: (StudentsController c) {
                                      return Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 200,
                                            child: DropDownSelectingMenu(
                                                selectedOption:
                                                    studentsController
                                                        .selectedGrade2.value,
                                                selectOptions:
                                                    studentsController
                                                        .selectGradeOptions2,
                                                setSelectedOption:
                                                    studentsController
                                                        .selectGradeOptions2,
                                                enableEdit: studentsController
                                                        .showInfo.value
                                                    ? studentsController
                                                            .isEditing.value
                                                        ? true
                                                        : false
                                                    : true),
                                          ),
                                          SizedBox(width: 20),
                                          SizedBox(
                                            height: 50,
                                            width: 200,
                                            child: DropDownSelectingMenu(
                                                selectedOption:
                                                    studentsController
                                                        .selectedClass2.value,
                                                selectOptions:
                                                    studentsController
                                                        .selectClassOptions2,
                                                setSelectedOption:
                                                    studentsController
                                                        .selectClassOptions2,
                                                enableEdit: studentsController
                                                        .showInfo.value
                                                    ? studentsController
                                                            .isEditing.value
                                                        ? true
                                                        : false
                                                    : true),
                                          ),
                                        ],
                                      );
                                    }),*/
                                SizedBox(
                                  height: 35.h,
                                ),
                                SizedBox(
                                  height: 500,
                                  width: Responsive.isDesktop(context)
                                      ? size.width / 3
                                      : size.width / 2,
                                  child: GetBuilder(
                                      init: StudentsController(),
                                      builder: (StudentsController c) {
                                        return FutureBuilder(
                                            future: c.getmyStudents(),
                                            builder: ((context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child: Text('Loading...'));
                                              }

                                              return c.mystudents.isEmpty
                                                  ? SizedBox(
                                                      height: 500,
                                                      child: Center(
                                                        child: Text(
                                                          'NO Students',
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
                                                        itemCount: c.mystudents
                                                            .value.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return StudentItem(
                                                            student: c
                                                                .mystudents
                                                                .value[index],
                                                            controller:
                                                                studentsController,
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
                                          studentsController
                                              .activeAddingStudent();
                                        },
                                        text: 'Add Student +'),
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
                : AddStudentScreen(
                    controller: studentsController,
                  );
          }),
    );
  }
}

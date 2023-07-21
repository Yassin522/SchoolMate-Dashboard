import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:school_management_system/view/screens/grades/grades-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/widgets/items/Grade-item.dart';
import 'package:school_management_system/view/utils/widgets/add-button.dart';
import '../../utils/constants/responsive.dart';
import '../../utils/widgets/header.dart';

class GradesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var textcontroller = TextEditingController();
    return SafeArea(
      child: SingleChildScrollView(
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
                    bottom: Responsive.isDesktop(context)
                        ? defaultPadding * 3
                        : Responsive.isTablet(context)
                            ? defaultPadding * 2
                            : defaultPadding),
                child: Header(
                  text: 'Grades',
                  size: size,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 500,
                    width: Responsive.isDesktop(context)
                        ? size.width / 3
                        : size.width / 2,
                    child: GetBuilder(
                      init: GradesController(),
                      builder: (GradesController controller) {
                        return FutureBuilder(
                            future: controller.getmyGrades(),
                            builder: ((context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: Text('Loading...'));
                              }

                              return Column(children: [
                                controller.mygrades.value.isEmpty
                                    ? Center(
                                        child: Text(
                                          'NO Grades',
                                          style: redHatBoldStyle(
                                              color: lightGray,
                                              fontSize: Responsive.isDesktop(
                                                      context)
                                                  ? 52
                                                  : Responsive.isTablet(context)
                                                      ? 40
                                                      : 32),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 500,
                                        width: Responsive.isDesktop(context)
                                            ? size.width / 3
                                            : size.width / 2,
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            height: 32,
                                          ),
                                          itemCount:
                                              controller.mygrades.value.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GradeItem(
                                              grade: controller
                                                  .mygrades.value[index],
                                            );
                                          },
                                        ),
                                      )
                              ]);
                            }));
                      },
                    ),
                  ),
                  Column(
                    children: [
                      GetBuilder(
                          init: GradesController(),
                          builder: (GradesController c) {
                            return AddButton(
                              press: () {
                                Get.defaultDialog(
                                    backgroundColor: backgroundColor,
                                    title: 'Add Grade',
                                    titleStyle: redHatMediumStyle(
                                        color: darkGray, fontSize: 28),
                                    contentPadding: EdgeInsets.all(20),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          onChanged: (value) {
                                            c.getSubjectOptions();
                                            c.update();
                                          },
                                          controller: c.gradeNameController,
                                          keyboardType: TextInputType.text,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            labelText: 'grade name',
                                            hintMaxLines: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        TextField(
                                          onChanged: (value) {},
                                          controller: c.gradeFeesController,
                                          keyboardType: TextInputType.text,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            labelText: 'grade fees',
                                            hintMaxLines: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        GetBuilder(
                                          init: GradesController(),
                                          builder: (GradesController c) {
                                            return Container(
                                              width:
                                                  Responsive.isDesktop(context)
                                                      ? size.width / 3
                                                      : size.width / 2,
                                              child: DropDownMultiSelect(
                                                options: c.subjectsOptions,
                                                whenEmpty: 'Chose Subjects',
                                                onChanged: (value) {
                                                  c.selectedSubjectsOptionList
                                                      .value = value;
                                                  c.selectedSubjectsOption
                                                      .value = '';
                                                  c.selectedSubjectsOptionList
                                                      .value
                                                      .forEach((element) {
                                                    c.selectedSubjectsOption
                                                            .value =
                                                        c.selectedSubjectsOption
                                                                .value +
                                                            ' ' +
                                                            element;
                                                  });

                                                  c.update();
                                                  print(c
                                                      .selectedSubjectsOptionList
                                                      .value);
                                                },
                                                selectedValues: c
                                                    .selectedSubjectsOptionList
                                                    .value,
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  GradesController c = Get.put(
                                                      GradesController());
                                                  c.addgrade();
                                                  // c.update();
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 110,
                                                  color: purple,
                                                  child: Center(
                                                    child: Text(
                                                      'submit',
                                                      style: redHatBoldStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 110,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Text(
                                                      'cancel',
                                                      style: redHatBoldStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    radius: 10.0);
                              },
                              text: 'Add Grade +',
                            );
                          }),
                      SizedBox(
                        height: Responsive.isDesktop(context) ? 28 : 16,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

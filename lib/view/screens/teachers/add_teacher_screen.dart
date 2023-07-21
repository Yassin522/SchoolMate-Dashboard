import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:school_management_system/models/teacher.dart';
import 'package:school_management_system/view/screens/teachers/teachers-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/widgets/cancel_button.dart';
import '../../utils/constants/responsive.dart';
import '../../utils/widgets/header.dart';
import '../../utils/widgets/inforamation_field.dart';
import '../../utils/widgets/select-menu.dart';
import '../../utils/widgets/submit_button.dart';

class AddTeacherScreen extends StatelessWidget {
  AddTeacherScreen({required this.controller});
  TeachersController controller;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: defaultPadding, right: defaultPadding, left: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: Responsive.isDesktop(context)
                      ? defaultPadding * 3
                      : Responsive.isTablet(context)
                          ? defaultPadding * 2
                          : defaultPadding),
              child: Header(
                  text: 'Teacher',
                  size: size,
                  logoutIconActivation: false,
                  goBackButtonActivation: true,
                  backTo: () {
                    controller.unactiveAddingTeacher();
                    controller.unShowInformation();
                    controller.stopUploadingInfo();
                  }),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 56, top: 40, bottom: defaultPadding),
              child: Text(
                'Teacher Information',
                style: redHatMediumStyle(
                    color: gray,
                    fontSize: Responsive.isDesktop(context)
                        ? 28
                        : Responsive.isTablet(context)
                            ? 24
                            : 16),
              ),
            ),
            Responsive(
              mobile: Column(
                children: [
                  TeacherInfo(
                    teacherInfo: controller,
                  ),
                  TeacherStudyInfo(
                    teacherInfo: controller,
                  )
                ],
              ),
              tablet: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TeacherInfo(
                      teacherInfo: controller,
                    ),
                    TeacherStudyInfo(
                      teacherInfo: controller,
                    )
                  ],
                ),
              ),
              desktop: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TeacherInfo(teacherInfo: controller),
                    TeacherStudyInfo(
                      teacherInfo: controller,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
                width: Responsive.isDesktop(context)
                    //here
                    ? 1056
                    : Responsive.isTablet(context)
                        ? 856
                        : 456,
                child: !controller.showInfo.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 38),
                            child: SubmitButton(
                              press: () {
                                controller.addTeacher();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 56,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 38),
                            child: CancelButton(
                                press: controller.unactiveAddingTeacher),
                          ),
                        ],
                      )
                    : !controller.isEditing.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 38),
                                child: SubmitButton(
                                  text: 'Edit',
                                  press: () {
                                    controller.enableEditing();
                                    print(controller.isEditing.value);
                                  },
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 38),
                                child: SubmitButton(
                                  press: () {
                                    print('submit');
                                    controller.addTeacher();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 56,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 38),
                                child: CancelButton(press: () {
                                  controller.disableEditing();
                                }),
                              ),
                            ],
                          ))
          ],
        ),
      ),
    );
  }
}

class TeacherInfo extends StatelessWidget {
  TeacherInfo({required this.teacherInfo});
  TeachersController teacherInfo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Responsive.isDesktop(context)
            ? 408
            : Responsive.isTablet(context)
                ? 380
                : 500,
        width: Responsive.isDesktop(context)
            //here
            ? 500
            : 400,
        child: Padding(
          padding: const EdgeInsets.only(left: 56),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InformationField(
                    label: 'First Name',
                    textController: teacherInfo.firstNameController,
                    icon: Icons.person,
                    enableEdit: teacherInfo.showInfo.value
                        ? teacherInfo.isEditing.value
                            ? true
                            : false
                        : true),
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Last Name',
                  textController: teacherInfo.lastNameController,
                  icon: Icons.person,
                  enableEdit: teacherInfo.showInfo.value
                      ? teacherInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Phone Number',
                  textController: teacherInfo.phoneNumberController,
                  icon: Icons.phone,
                  inputType: TextInputType.number,
                  enableEdit: teacherInfo.showInfo.value
                      ? teacherInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Email',
                  textController: teacherInfo.emailController,
                  icon: Icons.email,
                  enableEdit: teacherInfo.showInfo.value
                      ? teacherInfo.isEditing.value
                          ? true
                          : false
                      : true),
              // SizedBox(
              //   height: Responsive.isMobile(context) ? 16 : 20,
              // ),
              // Container(
              //   padding: EdgeInsets.only(
              //       left: 36,
              //       right: 16,
              //       top: Responsive.isDesktop(context) ? 4 : 0,
              //       bottom: Responsive.isDesktop(context) ? 4 : 0),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: lightGray, width: 3),
              //     borderRadius: BorderRadius.circular(20.r),
              //     color: white,
              //   ),
              //   child: DropDownMultiSelect(
              //     options: teacherInfo.subjectsOptions,
              //     whenEmpty: 'Subject',
              //     onChanged: (value) {
              //       teacherInfo.selectedsubjectsOptionList.value = value;
              //       teacherInfo.selectedsubjectsOption.value = '';
              //       teacherInfo.selectedsubjectsOptionList.value
              //           .forEach((element) {
              //         teacherInfo.selectedsubjectsOption.value =
              //             teacherInfo.selectedsubjectsOption.value +
              //                 ' ' +
              //                 element;
              //       });
              //       teacherInfo.update();
              //     },
              //     selectedValues: teacherInfo.selectedsubjectsOptionList.value,
              //   ),
              // ),
              if (teacherInfo.showInfo.value)
                Column(children: [
                  SizedBox(
                    height: Responsive.isMobile(context) ? 16 : 20,
                  ),
                  InformationField(
                      label: 'Grades',
                      textController: teacherInfo.teacherGradesController,
                      activeIcon: false,
                      enableEdit: false),
                  SizedBox(
                    height: Responsive.isMobile(context) ? 16 : 20,
                  ),
                ])
            ],
          ),
        ));
  }
}

class TeacherStudyInfo extends StatelessWidget {
  TeacherStudyInfo({required this.teacherInfo});
  TeachersController teacherInfo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Responsive.isDesktop(context)
            ? 408
            : Responsive.isTablet(context)
                ? 380
                : 340,
        width: Responsive.isDesktop(context)
            //here
            ? 500
            : 400,
        child: Padding(
          padding: const EdgeInsets.only(left: 56),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InformationField(
                    label: 'Study',
                    textController: teacherInfo.studyController,
                    icon: Icons.people,
                    enableEdit: teacherInfo.showInfo.value
                        ? teacherInfo.isEditing.value
                            ? true
                            : false
                        : true),
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Specialization',
                  textController: teacherInfo.specializationController,
                  icon: Icons.people,
                  enableEdit: teacherInfo.showInfo.value
                      ? teacherInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'University',
                  textController: teacherInfo.universityController,
                  icon: Icons.phone,
                  inputType: TextInputType.number,
                  enableEdit: teacherInfo.showInfo.value
                      ? teacherInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Graduate Year',
                  textController: teacherInfo.graduateYearController,
                  icon: Icons.email,
                  enableEdit: teacherInfo.showInfo.value
                      ? teacherInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Password',
                  textController: teacherInfo.additionalInfoController,
                  icon: Icons.more_horiz,
                  enableEdit: teacherInfo.showInfo.value
                      ? teacherInfo.isEditing.value
                          ? false
                          : false
                      : true),
            ],
          ),
        ));
  }
}

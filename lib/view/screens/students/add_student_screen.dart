import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/view/screens/students/students-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/widgets/cancel_button.dart';
import '../../utils/constants/responsive.dart';
import '../../utils/widgets/header.dart';
import '../../utils/widgets/inforamation_field.dart';
import '../../utils/widgets/select-menu.dart';
import '../../utils/widgets/submit_button.dart';

class AddStudentScreen extends StatelessWidget {
  AddStudentScreen({required this.controller});
  StudentsController controller;

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
                text: 'Student',
                size: size,
                logoutIconActivation: false,
                goBackButtonActivation: true,
                backTo: () {
                  controller.unactiveAddingStudent();
                  controller.unShowInformation();
                  controller.stopUploadingInfo();
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 56, top: 40, bottom: defaultPadding),
              child: Text(
                'Student Information',
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
                  StudentInfo(
                    studentInfo: controller,
                  ),
                  StudentParentInfo(
                    studentInfo: controller,
                  )
                ],
              ),
              tablet: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    StudentInfo(studentInfo: controller),
                    StudentParentInfo(
                      studentInfo: controller,
                    )
                  ],
                ),
              ),
              desktop: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    StudentInfo(studentInfo: controller),
                    StudentParentInfo(
                      studentInfo: controller,
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
                                print('submit');
                                controller.addStudent();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 56,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 38),
                            child: CancelButton(
                                press: controller.unactiveAddingStudent),
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
                                    print('editttttttttt');
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
                                  press: () async {
                                    await controller.addStudent();
                                    
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

class StudentInfo extends StatelessWidget {
  StudentInfo({required this.studentInfo});
  StudentsController studentInfo;
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
                    textController: studentInfo.firstnamecontroller,
                    icon: Icons.person,
                    enableEdit: studentInfo.showInfo.value
                        ? studentInfo.isEditing.value
                            ? true
                            : false
                        : true),
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Last Name',
                  textController: studentInfo.lastnamecontroller,
                  icon: Icons.person,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Phone Number',
                  textController: studentInfo.phoneNumberController,
                  icon: Icons.phone,
                  inputType: TextInputType.number,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Email',
                  textController: studentInfo.emailcontroller,
                  icon: Icons.email,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'paid fee',
                  textController: studentInfo.paidFeecontroller,
                  icon: Icons.attach_money,
                  inputType: TextInputType.number,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              DropDownSelectingMenu(
                  selectedOption: studentInfo.selectedGrade.value,
                  selectOptions: studentInfo.selectGradeOptions,
                  setSelectedOption: studentInfo.setSelectedGrade,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              DropDownSelectingMenu(
                  selectedOption: studentInfo.selectedClass.value,
                  selectOptions: studentInfo.selectClassOptions,
                  setSelectedOption: studentInfo.setSelectedClass,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? true
                          : false
                      : true),
            ],
          ),
        ));
  }
}

class StudentParentInfo extends StatelessWidget {
  StudentParentInfo({required this.studentInfo});
  StudentsController studentInfo;
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
                    label: 'Father Name',
                    textController: studentInfo.fathernamecontroller,
                    icon: Icons.people,
                    enableEdit: studentInfo.showInfo.value
                        ? studentInfo.isEditing.value
                            ? true
                            : false
                        : true),
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Mother Name',
                  textController: studentInfo.mothercontroller,
                  icon: Icons.people,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Parent\'s Phone Number',
                  textController: studentInfo.parentphonecontroller,
                  icon: Icons.phone,
                  inputType: TextInputType.number,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Parent\'s Email',
                  textController: studentInfo.parentsemailcontroller,
                  icon: Icons.email,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? true
                          : false
                      : true),
              SizedBox(
                height: Responsive.isMobile(context) ? 16 : 20,
              ),
              InformationField(
                  label: 'Password',
                  textController: studentInfo.additionalInforamtionController,
                  icon: Icons.more_horiz,
                  enableEdit: studentInfo.showInfo.value
                      ? studentInfo.isEditing.value
                          ? false
                          : false
                      : true),
            ],
          ),
        ));
  }
}

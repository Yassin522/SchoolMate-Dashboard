import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/view/screens/schedules/schedules-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:path/path.dart';

import '../../utils/constants/responsive.dart';
import '../../utils/constants/utils.dart';
import '../../utils/widgets/add-button.dart';
import '../../utils/widgets/cliackable_text.dart';
import '../../utils/widgets/header.dart';
import '../../utils/widgets/items/secheduleitem.dart';

File? file;
UploadTask? sch;

class SchedulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                            : defaultPadding),
                child: Header(
                  text: 'Schedules',
                  size: size,
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: defaultPadding),
                        child: SchedulesOptions(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 460,
                    width: Responsive.isDesktop(context)
                        ? size.width / 3
                        : size.width / 2,
                        child: GetBuilder(
                            init: SchedulesController(),
                            builder: (SchedulesController c) {
                              return FutureBuilder(
                                  future: c.getmyWeeklySchedules(),
                                  builder: ((context, AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Text('Loading...'));
                                    }
                      
                                    return ((c.isTeacher &
                                                c.Weeklylist.isEmpty) ||
                                            (c.isStudent & c.Examlist.isEmpty))
                                        ? SizedBox(
                                            height: 460,
                                            child: Center(
                                              child: Text(
                                                'NO Schedules',
                                                style: redHatBoldStyle(
                                                    color: lightGray,
                                                    fontSize:
                                                        Responsive.isDesktop(
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
                                            height: 460,
                                            width: Responsive.isDesktop(context)
                                                ? size.width / 3
                                                : size.width / 2,
                                            child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                height: 32,
                                              ),
                                              itemCount: c.isTeacher.value
                                                  ? c.Weeklylist.length
                                                  : c.Examlist.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return ScheduleItem(
                                                    schedule: c.isTeacher.value
                                                        ? c.Weeklylist[index]
                                                        : c.Examlist[index]);
                                              },
                                            ),
                                          );
                                  }));
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 55.w,
                  ),
                  GetBuilder(
                      init: SchedulesController(),
                      builder: (SchedulesController c) {
                        return Padding(
                          padding: EdgeInsets.only(
                              right: Responsive.isDesktop(context)
                                  ? 40
                                  : Responsive.isTablet(context)
                                      ? 20
                                      : 0),
                          child: Column(
                            children: [
                              AddButton(
                                  press: () {
                                    Get.defaultDialog(
                                        backgroundColor: backgroundColor,
                                        title: 'Add Schedule',
                                        titleStyle: redHatMediumStyle(
                                            color: darkGray, fontSize: 28),
                                        contentPadding: EdgeInsets.all(20),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GetBuilder(
                                                init: SchedulesController(),
                                                builder:
                                                    (SchedulesController ccc) {
                                                  return Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20, right: 10),
                                                    width: Responsive.isDesktop(
                                                            context)
                                                        ? size.width / 3
                                                        : size.width / 2,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: lightGray,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: white,
                                                    ),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        hint: Text(
                                                          "selectedOption",
                                                          style:
                                                              redHatMediumStyle(
                                                                  color: gray,
                                                                  fontSize: Responsive
                                                                          .isDesktop(
                                                                              context)
                                                                      ? 24
                                                                      : Responsive.isTablet(
                                                                              context)
                                                                          ? 20
                                                                          : 16),
                                                        ),
                                                        value: ccc.dropdownvalue
                                                            .value,
                                                        icon: Icon(Icons
                                                            .keyboard_arrow_down),
                                                        items: ccc.items.map(
                                                            (String items) {
                                                          return DropdownMenuItem(
                                                              value: items,
                                                              child:
                                                                  Text(items));
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          ccc.changevalue(
                                                              newValue);
                                                          ccc.update();

                                                          print(ccc
                                                              .dropdownvalue
                                                              .value);
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GetBuilder(
                                                init: SchedulesController(),
                                                builder:
                                                    (SchedulesController c) {
                                                  return Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20, right: 10),
                                                    width: Responsive.isDesktop(
                                                            context)
                                                        ? size.width / 3
                                                        : size.width / 2,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: lightGray,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: white,
                                                    ),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        hint: Text(
                                                          "selectedOption",
                                                          style:
                                                              redHatMediumStyle(
                                                                  color: gray,
                                                                  fontSize: Responsive
                                                                          .isDesktop(
                                                                              context)
                                                                      ? 24
                                                                      : Responsive.isTablet(
                                                                              context)
                                                                          ? 20
                                                                          : 16),
                                                        ),
                                                        value: c.dropdownvalue3
                                                            .value,
                                                        icon: Icon(Icons
                                                            .keyboard_arrow_down),
                                                        items: c.items3.map(
                                                            (String items) {
                                                          return DropdownMenuItem(
                                                              value: items,
                                                              child:
                                                                  Text(items));
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          c.changevalue3(
                                                              newValue);
                                                          //   c.update();

                                                          print(c.dropdownvalue3
                                                              .value);
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            GetBuilder(
                                              init: SchedulesController(),
                                              builder: (SchedulesController c) {
                                                return c.dropdownvalue.value ==
                                                        'classroom'
                                                    ? Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 10),
                                                            width: Responsive
                                                                    .isDesktop(
                                                                        context)
                                                                ? size.width / 3
                                                                : size.width /
                                                                    2,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      lightGray,
                                                                  width: 3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: white,
                                                            ),
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                hint: Text(
                                                                  "selectedOption",
                                                                  style: redHatMediumStyle(
                                                                      color: gray,
                                                                      fontSize: Responsive.isDesktop(context)
                                                                          ? 24
                                                                          : Responsive.isTablet(context)
                                                                              ? 20
                                                                              : 16),
                                                                ),
                                                                value: c
                                                                    .dropdownvalue4
                                                                    .value,
                                                                icon: Icon(Icons
                                                                    .keyboard_arrow_down),
                                                                items: c.items4
                                                                    .value
                                                                    .map((String
                                                                        items) {
                                                                  return DropdownMenuItem(
                                                                      value:
                                                                          items,
                                                                      child: Text(
                                                                          items));
                                                                }).toList(),
                                                                onChanged: (String?
                                                                    newValue) {
                                                                  c.changevalue4(
                                                                      newValue);

                                                                  print(c
                                                                      .dropdownvalue4
                                                                      .value);

                                                                  c.getclassOptions(c
                                                                      .dropdownvalue4
                                                                      .value);

                                                                  c.update();
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 10),
                                                            width: Responsive
                                                                    .isDesktop(
                                                                        context)
                                                                ? size.width / 3
                                                                : size.width /
                                                                    2,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      lightGray,
                                                                  width: 3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: white,
                                                            ),
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                hint: Text(
                                                                  "selectedOption",
                                                                  style: redHatMediumStyle(
                                                                      color: gray,
                                                                      fontSize: Responsive.isDesktop(context)
                                                                          ? 24
                                                                          : Responsive.isTablet(context)
                                                                              ? 20
                                                                              : 16),
                                                                ),
                                                                value: c
                                                                    .dropdownvalue2
                                                                    .value,
                                                                icon: Icon(Icons
                                                                    .keyboard_arrow_down),
                                                                items: c.items2
                                                                    .value
                                                                    .map((String
                                                                        items) {
                                                                  return DropdownMenuItem(
                                                                      value:
                                                                          items,
                                                                      child: Text(
                                                                          items));
                                                                }).toList(),
                                                                onChanged: (String?
                                                                    newValue) {
                                                                  c.changevalue2(
                                                                      newValue);

                                                                  print(c
                                                                      .dropdownvalue2
                                                                      .value);

                                                                  //    c.update();
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20,
                                                                right: 10),
                                                        width: Responsive
                                                                .isDesktop(
                                                                    context)
                                                            ? size.width / 3
                                                            : size.width / 2,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: lightGray,
                                                              width: 3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: white,
                                                        ),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: DropdownButton<
                                                              String>(
                                                            hint: Text(
                                                              "selectedOption",
                                                              style: redHatMediumStyle(
                                                                  color: gray,
                                                                  fontSize: Responsive.isDesktop(context)
                                                                      ? 24
                                                                      : Responsive.isTablet(context)
                                                                          ? 20
                                                                          : 16),
                                                            ),
                                                            value: c
                                                                .dropdownvalue5
                                                                .value,
                                                            icon: Icon(Icons
                                                                .keyboard_arrow_down),
                                                            items: c
                                                                .items5.value
                                                                .map((String
                                                                    items) {
                                                              return DropdownMenuItem(
                                                                  value: items,
                                                                  child: Text(
                                                                      items));
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              c.changevalue5(
                                                                  newValue);

                                                              print(c
                                                                  .dropdownvalue5
                                                                  .value);

                                                              //  c.update();
                                                            },
                                                          ),
                                                        ),
                                                      );
                                              },
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            GetBuilder(
                                                init: SchedulesController(),
                                                builder:
                                                    (SchedulesController c) {
                                                  return InkWell(
                                                    onTap: () async {
                                                      c.fileurl.value =
                                                          await selectfile();

                                                      print("ffffffffffff");
                                                      print(c.fileurl.value);
                                                      if (c.fileurl.value !=
                                                          'nothing') {
                                                        AwesomeDialog(
                                                          width: 350.w,
                                                          context: context,
                                                          animType: AnimType
                                                              .LEFTSLIDE,
                                                          headerAnimationLoop:
                                                              false,
                                                          dialogType:
                                                              DialogType.SUCCES,
                                                          showCloseIcon: true,
                                                          title: 'Succes',
                                                          desc: 'File uploaded',
                                                          btnOkOnPress: () {
                                                            debugPrint(
                                                                'OnClcik');
                                                          },
                                                          btnOkIcon: Icons
                                                              .check_circle,
                                                          onDissmissCallback:
                                                              (type) {
                                                            debugPrint(
                                                                'Dialog Dissmiss from callback $type');
                                                          },
                                                        ).show();
                                                      }

                                                      c.update();
                                                    },
                                                    child: Container(
                                                      height: 120.h,
                                                      padding: EdgeInsets.only(
                                                          left: 60, right: 60),
                                                      color: lightPurple,
                                                      child: Center(
                                                        child: Text(
                                                          c.fileurl.value ==
                                                                  'nothing'
                                                              ? 'Choose file'
                                                              : 'Select new file',
                                                          style:
                                                              redHatBoldStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GetBuilder(
                                                      init:
                                                          SchedulesController(),
                                                      builder:
                                                          (SchedulesController
                                                              c) {
                                                        return InkWell(
                                                          onTap: () async {
                                                            if (c.fileurl
                                                                    .value ==
                                                                'nothing') {
                                                              showSnackBar(
                                                                  'Please select a file',
                                                                  context);
                                                            } else {
                                                              c.addSchedule();
                                                            }

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
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                  InkWell(
                                                    onTap: () {
                                                      c.fileurl.value =
                                                          'nothing';
                                                      c.update();
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 110,
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Text(
                                                          'cancel',
                                                          style:
                                                              redHatBoldStyle(
                                                                  color: Colors
                                                                      .grey),
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
                                  text: 'Add schedule +'),
                              SizedBox(
                                height: Responsive.isDesktop(context) ? 28 : 16,
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> selectfile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;

      // upload file
      final snapshot = await FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putData(fileBytes!);

      final urlDownload = await snapshot.ref.getDownloadURL();
      print('Download-link : $urlDownload');
      return urlDownload;
    } else
      return 'nothing';
  }
}

class SchedulesOptions extends StatelessWidget {
  const SchedulesOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SchedulesController(),
        builder: (SchedulesController c) {
          return Row(
            children: [
              ClicableText(
                text: 'Teacher',
                style: redHatMediumStyle(
                    color: c.isTeacher.value ? purple : gray,
                    fontSize: Responsive.isDesktop(context)
                        ? 24
                        : Responsive.isTablet(context)
                            ? 20
                            : 16),
                function: c.selectWeekly,
                activeLine: true,
                lineColor: c.isTeacher.value ? lightPurple : lightGray,
                length: Responsive.isMobile(context)
                    ? 48
                    : Responsive.isTablet(context)
                        ? 60
                        : 72,
              ),
              SizedBox(
                width: Responsive.isMobile(context)
                    ? 46
                    : Responsive.isTablet(context)
                        ? 108
                        : 48,
              ),
              ClicableText(
                text: 'Student',
                style: redHatMediumStyle(
                    color: c.isStudent.value ? purple : gray,
                    fontSize: Responsive.isDesktop(context)
                        ? 24
                        : Responsive.isTablet(context)
                            ? 20
                            : 16),
                function: c.selectExam,
                activeLine: true,
                lineColor: c.isStudent.value ? lightPurple : lightGray,
                length: Responsive.isMobile(context)
                    ? 72
                    : Responsive.isTablet(context)
                        ? 84
                        : 104,
              ),
            ],
          );
        });
  }
}

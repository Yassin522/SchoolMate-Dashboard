import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:school_management_system/models/classes.dart';
import 'package:school_management_system/view/screens/classes/classes-controller.dart';
import 'package:school_management_system/view/screens/grades/grades-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/widgets/add-button.dart';
import 'package:school_management_system/view/utils/widgets/items/class-item.dart';
import 'package:school_management_system/view/utils/widgets/delete-button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/responsive.dart';
import '../../utils/widgets/header.dart';
import '../main-screen/main-screen.dart';

class ClassesScreen extends StatelessWidget {
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
                ),
                child: Header(
                  text: 'Classes',
                  size: size,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    GetBuilder(
                        init: ClassesController(),
                        builder: (ClassesController c) {
                          return Container(
                            width: Responsive.isDesktop(context)
                                ? size.width / 3
                                : size.width / 2,
                            child: DropDownMultiSelect(
                              options: c.gradesOptions,
                              onChanged: (value) {
                                c.selectedGradesOptionList.value = value;
                                c.selectedGradesOption.value = '';
                                c.selectedGradesOptionList.value
                                    .forEach((element) {
                                  c.selectedGradesOption.value =
                                      c.selectedGradesOption.value +
                                          ' ' +
                                          element;
                                });

                                c.ok.value = false;
                                if (c.selectedGradesOptionList.value.isEmpty) {
                                  c.ok.value = true;
                                }
                                c.update();
                                print(c.selectedGradesOptionList.value);
                              },
                              selectedValues: c.selectedGradesOptionList.value,
                              whenEmpty: 'Grade',
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 500,
                    width: Responsive.isDesktop(context)
                        ? size.width / 3
                        : size.width / 2,
                      child: GetBuilder(
                        init: ClassesController(),
                        builder: (ClassesController c) {
                          return FutureBuilder(
                            future: c.getmyClasses(),
                            builder: ((context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: Text('Loading...'));
                              }
                    
                              return c.myclasses.isEmpty
                                  ? SizedBox(
                                      height: 500,
                                      child: Center(
                                        child: Text(
                                          'NO Classes',
                                          style: redHatBoldStyle(
                                              color: lightGray,
                                              fontSize: Responsive.isDesktop(
                                                      context)
                                                  ? 52
                                                  : Responsive.isTablet(context)
                                                      ? 40
                                                      : 32),
                                        ),
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
                                        itemCount: c.myclasses.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ClassItem(
                                            gClass: c.myclasses[index],
                                          );
                                        },
                                      ),
                                    );
                            }),
                          );
                        },
                      ),
                    ),
                  ]),
                  GetBuilder(
                    init: ClassesController(),
                    builder: (ClassesController c) {
                      return Padding(
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
                                  Get.defaultDialog(
                                      backgroundColor: backgroundColor,
                                      title: 'Add Class room',
                                      titleStyle: redHatMediumStyle(
                                          color: darkGray, fontSize: 28),
                                      contentPadding: EdgeInsets.all(20),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GetBuilder(
                                              init: ClassesController(),
                                              builder: (ClassesController ccc) {
                                                return Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20, right: 10),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: lightGray,
                                                        width: 3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    color: white,
                                                  ),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton<String>(
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
                                                      value: ccc
                                                          .dropdownvalue.value,
                                                      icon: Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: ccc.items.value
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(items));
                                                      }).toList(),
                                                      onChanged:
                                                          (String? newValue) {
                                                        ccc.changevalue(
                                                            newValue);

                                                        print(ccc.dropdownvalue
                                                            .value);
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextField(
                                            onChanged: (value) {},
                                            controller: c.SectionController,
                                            keyboardType: TextInputType.text,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              labelText: 'Section',
                                              hintMaxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          GetBuilder(
                                            init: ClassesController(),
                                            builder: (ClassesController c) {
                                              return Container(
                                                width: Responsive.isDesktop(
                                                        context)
                                                    ? size.width / 3
                                                    : size.width / 2,
                                                child: DropDownMultiSelect(
                                                  options: c.teachersOptions,
                                                  whenEmpty: 'Chose Teachers',
                                                  onChanged: (value) {
                                                    c.selectedTeachersOptionList
                                                        .value = value;
                                                    c.selectedTeachersOption
                                                        .value = '';
                                                    c.selectedTeachersOptionList
                                                        .value
                                                        .forEach((element) {
                                                      c.selectedTeachersOption
                                                              .value =
                                                          c.selectedTeachersOption
                                                                  .value +
                                                              ' ' +
                                                              element;
                                                    });

                                                    c.update();
                                                    print(c
                                                        .selectedTeachersOptionList
                                                        .value);
                                                  },
                                                  selectedValues: c
                                                      .selectedTeachersOptionList
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
                                                    ClassesController cc =
                                                        Get.put(
                                                            ClassesController());
                                                    cc.addclass();
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
                                                            color:
                                                                Colors.white),
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
                                text: 'Add Class +'),
                          ],
                        ),
                      );
                    },
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

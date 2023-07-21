import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/view/routes/app_pages.dart';
import 'package:school_management_system/view/screens/login/login_controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/my_icons.dart';
import 'package:school_management_system/view/utils/widgets/bordered_button.dart';
import 'package:school_management_system/view/utils/widgets/cliackable_text.dart';
import 'package:school_management_system/view/utils/widgets/custom_button.dart';

import '../../utils/constants/font_style.dart';
import '../../utils/constants/utils.dart';
import '../../utils/widgets/custom_formfield.dart';

class LoginScreen extends StatelessWidget {
  final LoginConroller controller = Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Pics pics = Pics();

    void Login() async {
      String res = "Some error occured";
      print(controller.emailController.text);
      print(controller.passwordController.text);
      try {
        var ref = await FirebaseFirestore.instance
            .collection('admin')
            .get()
            .then((value) {
          value.docs.forEach((element) {
            if (controller.emailController.text != element['email'] ||
                controller.passwordController.text != element['password']) {
              res = "Some errors occured";
            } else
              res = "sucess";
          });
        });
      } catch (err) {
        res = err.toString();
      }

      if (res == "sucess") {
        Get.toNamed(AppPages.mainScreen);
      } else {
        showSnackBar(res, context);
      }
    }

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(background), fit: BoxFit.cover)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 134.h),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'SchoolMate',
                      style: redHatBoldStyle(
                          color: purple, fontSize: size.width / 19.2),
                    ),
                    Text(
                      'Enjoy Managing Your School',
                      style: redHatMediumStyle(
                          color: lightPurple, fontSize: size.width / 32),
                    ),
                    SizedBox(
                      height: 134.h,
                    ),
                    Obx(() => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / 3.5),
                          child: Column(
                            children: [
                              customFormField(
                                controller: controller.emailController,
                                label: 'Email',
                                prefix: Icons.email,
                                onChange: (String val) {},
                                type: TextInputType.emailAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'email must not be empty';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(height: 52.h),
                              customFormField(
                                controller: controller.passwordController,
                                label: 'Password',
                                prefix: Icons.lock,
                                onChange: (String val) {},
                                suffix: controller.isPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                isPassword: controller.isPassword.value,
                                suffixPressed: () {
                                  controller.showPassword();
                                },
                                type: TextInputType.visiblePassword,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'password is too short';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 32.h),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: ClicableText(
                                    text: 'Forgot Password?',
                                    style: sfRegularStyle(
                                        color: blue, fontSize: 40.sp),
                                    function: () {
                                      print('forgot password?');
                                    }),
                              ),
                              SizedBox(
                                height: 134.h,
                              ),
                              CustomButton(
                                press: () {
                                  Get.offNamed(AppPages.mainScreen);
                                },
                                height: 120.h,
                                width: size.width,
                                radius: 20.r,
                              ),
                            ],
                          ),
                        ))
                  ],
                  // : CrossAxisAlignment.end,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: size.height / 27, left: size.width / 48),
              child: BorderedButton(
                function: () {
                  print('contact us');
                },
                text: 'Contact Us',
                icon: MyIcons.contact_us,
                textStyle: redHatBoldStyle(color: purple, fontSize: 40.sp),
              
                color: purple,
                borderSize: 5.h,
                radius: 20.r,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}

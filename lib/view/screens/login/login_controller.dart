import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';

class LoginConroller extends GetxController {
  var isPassword = true.obs;
  var pressed = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void showPassword() {
    this.isPassword.value = !isPassword.value;
  }

  void press() {
    this.pressed.value = !pressed.value;
  }
}

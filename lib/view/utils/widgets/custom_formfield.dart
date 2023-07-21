import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:school_management_system/view/utils/constants/font_style.dart';

import '../constants/constant.dart';

Widget customFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  bool pressed = false,
  Function? press,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Color? color,
  Function? suffixPressed,
}) =>
    Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: black.withOpacity(0.15),
            blurRadius: 12.r,
            offset: Offset(0, 3))
      ]),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: sfRegularStyle(color: purple, fontSize: 40.sp),
        obscureText: isPassword,
        onFieldSubmitted: (s) {
          onSubmit!(s);
        },
        onChanged: (s) {
          onChange!(s);
        },
        validator: validate,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(20),
            labelText: label,
            prefixIcon: Icon(
              prefix,
              color: lightGray,
            ),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: () {
                      suffixPressed!();
                    },
                    icon: Icon(
                      suffix,
                      color: lightGray,
                    ),
                  )
                : null,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: lightGray, width: 2.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: lightPurple, width: 2.w),
            ),
            floatingLabelStyle:
                sfRegularStyle(color: lightPurple, fontSize: 40.sp),
            labelStyle: sfRegularStyle(color: lightGray, fontSize: 40.sp)),
      ),
    );

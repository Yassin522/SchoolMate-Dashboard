import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/constants/responsive.dart';

class BorderedButton extends StatelessWidget {
  BorderedButton(
      {required this.function,
      required this.text,
      this.color=purple,
      this.radius=20,
      this.height=100,
      this.width=100,
      this.borderSize=2,
      required this.icon,
      required this.textStyle});
  String text;
  Color color;
  double height;
  double width;
  double radius;
  double borderSize;
  TextStyle? textStyle ;
  Function function;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: borderSize, color: color),borderRadius: BorderRadius.circular(radius)),
        height: 48,
        width: 140,
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon,color: color,size: 36.h,),
              Text(
                text,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

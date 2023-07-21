import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/widgets/cancel_button.dart';
import '../constants/constant.dart';
import '../constants/responsive.dart';

class WeekDay extends StatelessWidget {
  WeekDay(
      {this.text = 'day',
      this.onPress = null,
      this.isSelected = false,
      this.isActiveDay = false});
  String text;
  bool isSelected;
  bool isActiveDay;
  var onPress;
  @override
  Widget build(BuildContext context) {
    double radius = isSelected
        ? Responsive.isDesktop(context)
            ? 76
            : Responsive.isTablet(context)
                ? 72
                : 60
        : Responsive.isDesktop(context)
            ? 60
            : Responsive.isTablet(context)
                ? 56
                : 48;

    return SizedBox(
      width: radius+20,
      height:Responsive.isMobile(context)?radius+40: radius+20,
      child: Center(
        child: Column(
          children: [
            isSelected
                ? InkWell(
                    onTap: onPress,
                    child: Animator<double>(
                      cycles: 0,
                      curve: Curves.easeInToLinear,
                      tween: Tween<double>(begin: radius, end: radius+8),
                      duration: Duration(milliseconds: 1500),
                      builder: (context, animatorState, child) => Container(
                          height: animatorState.value,
                          width: animatorState.value,
                          decoration: isActiveDay
                              ? BoxDecoration(
                                  gradient: gradientColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                      BoxShadow(
                                          color: black.withOpacity(0.25),
                                          blurRadius: 12.r,
                                          offset: Offset(0, 3))
                                    ])
                              : BoxDecoration(
                                  color: white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: gray, width: 2)),
                          child: Center(
                              child: Text(
                            text,
                            style: isActiveDay
                                ? redHatBoldStyle(color: white, fontSize: 24)
                                : redHatMediumStyle(color: gray, fontSize: 20),
                          ))),
                    ),
                  )
                : InkWell(
                    onTap: onPress,
                    child: Container(
                        height: radius,
                        width: radius,
                        decoration: isActiveDay
                            ? BoxDecoration(
                                color: lightPurple,
                                shape: BoxShape.circle,
                              )
                            : BoxDecoration(
                                color: white,
                                shape: BoxShape.circle,
                                border: Border.all(color: gray, width: 2)),
                        child: Center(
                            child: Text(
                          text,
                          style: isActiveDay
                              ? redHatMediumStyle(color: white, fontSize: 20)
                              : redHatMediumStyle(color: gray, fontSize: 20),
                        ))),
                  ),
            // if (isSelected)
            //     Column(
            //       children: [
            //         SizedBox(
            //           height: 20,
    
            //     ),
            //     CancelButton(
            //       press: () {
            //         print('bo3bo3');
            //       },
            //       text: 'Daily Check',
            //     ),]
            //     )
          ],
        ),
      ),
    );
  }
}

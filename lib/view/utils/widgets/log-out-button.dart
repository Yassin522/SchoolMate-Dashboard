import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant.dart';
import '../constants/font_style.dart';
import '../constants/responsive.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (){},
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: black.withOpacity(0.15),
                  blurRadius: 12.r,
                  offset: Offset(0, 3))
            ],
            color: darkPurple,
            borderRadius: BorderRadius.circular(Responsive.isDesktop(context)? 20.r:Responsive.isTablet(context)?16.r:14.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:Responsive.isMobile(context)?defaultPadding :defaultPadding * 2.w,
              vertical: defaultPadding.h),
          child: Center(
              child: Text(
            'log out',
            style: redHatBoldStyle(
                color: white, fontSize:Responsive.isDesktop(context)? 24:Responsive.isTablet(context)?16:12),
          )),
        ),
      ),
    );
  }
}
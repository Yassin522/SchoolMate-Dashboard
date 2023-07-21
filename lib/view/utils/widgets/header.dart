import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_system/view/screens/main-screen/main-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/constants/responsive.dart';
import 'package:school_management_system/view/utils/widgets/menu.dart';

import 'log-out-button.dart';

class Header extends StatelessWidget {
  Header(
      {Key? key,
      required this.size,
      required this.text,
      this.logoutIconActivation = true,
      this.goBackButtonActivation = false,
      this.backTo = null})
      : super(key: key);

  final Size size;
  final String text;
  bool logoutIconActivation;
  bool goBackButtonActivation;
  var backTo;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          if (!goBackButtonActivation)
            IconButton(
                onPressed: () => navigationController.controlMenu(),
                icon: Icon(Icons.menu)),
        if (goBackButtonActivation)
          Padding(
            padding: EdgeInsets.only(right: defaultPadding),
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: purple,
                  size: Responsive.isDesktop(context)
                      ? 32
                      : Responsive.isTablet(context)
                          ? 24
                          : 20),
              onPressed: backTo,
            ),
          ),
        Text(
          text,
          style: redHatMediumStyle(
              color: darkGray,
              fontSize: Responsive.isDesktop(context)
                  ? 32
                  : Responsive.isTablet(context)
                      ? 24
                      : 16),
        ),
        /*Spacer(),
        if (logoutIconActivation) LogoutButton()*/
      ],
    );
  }
}

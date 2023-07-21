import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/constants/responsive.dart';
import 'package:intl/intl.dart';

import '../../../../models/Reports.dart';
import '../../../../models/emails.dart';

class EmailItem extends StatelessWidget {
  EmailItem({required this.email});

  Email email;
  DateFormat _dateFormat = DateFormat('y-MM-d');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.defaultDialog(
            title: '${email.senderName}',
            titleStyle: redHatBoldStyle(
                color: purple,
                fontSize: 32),
            content: Container(
                width:500,
                child: Text(
                  '${email.contain}',
                  style: redHatMediumStyle(
                      fontSize: 28,
                      color: gray),
                )),
            backgroundColor: backgroundColor,radius: 16);
      },
      child: Container(
        decoration: myDecoration,
        child: Padding(
          padding: EdgeInsets.all(Responsive.isMobile(context)
              ? defaultPadding / 2
              : defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${email.senderName}',
                style: redHatMediumStyle(
                    color: white,
                    fontSize: Responsive.isDesktop(context)
                        ? 28
                        : Responsive.isTablet(context)
                            ? 24
                            : 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => {print('edit')},
                    icon: Icon(Icons.edit),
                    color: white,
                  ),
                  SizedBox(
                    height: Responsive.isDesktop(context)
                        ? 8
                        : Responsive.isTablet(context)
                            ? 6
                            : 4,
                  ),
                  Text('${_dateFormat.format(email.date)}',
                      style: redHatRegularStyle(
                          color: white,
                          fontSize: Responsive.isDesktop(context) ? 16 : 12)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

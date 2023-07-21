import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/models/Reports.dart';
import 'package:school_management_system/models/emails.dart';
import 'package:school_management_system/view/screens/reports/reports-controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/widgets/add-button.dart';
import 'package:school_management_system/view/utils/widgets/cliackable_text.dart';
import 'package:school_management_system/view/utils/widgets/delete-button.dart';
import 'package:school_management_system/view/utils/widgets/items/email-item.dart';
import 'package:school_management_system/view/utils/widgets/items/report-item.dart';
import '../../utils/constants/responsive.dart';
import '../../utils/widgets/header.dart';

class ReportsAndEmailsScreen extends StatelessWidget {
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
                  text: 'Reports & Emails',
                  size: size,
                ),
              ),
              GetBuilder(
                  init: ReportsAndEmailsController(),
                  builder:
                      (ReportsAndEmailsController reportsAndEmailsController) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: defaultPadding),
                              child: PickReportsOrEmails(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GetBuilder(
                                init: ReportsAndEmailsController(),
                                builder: (ReportsAndEmailsController c) {
                                  return FutureBuilder(
                                      future: c.getmyReports(),
                                      builder:
                                          ((context, AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child: Text('Loading...'));
                                        }

                                        return ((reportsAndEmailsController
                                                        .isReports &
                                                    c.myreporst.isEmpty) ||
                                                (reportsAndEmailsController
                                                        .isEmails &
                                                    emails.isEmpty))
                                            ? SizedBox(
                                                height: 500,
                                                child: Center(
                                                  child: Text(
                                                    reportsAndEmailsController
                                                            .isEmails.value
                                                        ? 'NO EMAILS'
                                                        : 'NO REPORTS',
                                                    style: redHatBoldStyle(
                                                        color: lightGray,
                                                        fontSize: Responsive
                                                                .isDesktop(
                                                                    context)
                                                            ? 50
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 40
                                                                : 32),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 500,
                                                width: Responsive.isDesktop(
                                                        context)
                                                    ? size.width / 3
                                                    : size.width / 2,
                                                child:
                                                    reportsAndEmailsController
                                                            .isReports.value
                                                        ? ListView.separated(
                                                            separatorBuilder:
                                                                (context,
                                                                        index) =>
                                                                    SizedBox(
                                                              height: 32,
                                                            ),
                                                            itemCount: c
                                                                .myreporst
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return ReportItem(
                                                                  report:
                                                                      c.myreporst[
                                                                          index]);
                                                            },
                                                          )
                                                        : ListView.separated(
                                                            separatorBuilder:
                                                                (context,
                                                                        index) =>
                                                                    SizedBox(
                                                              height: 32,
                                                            ),
                                                            itemCount:
                                                                emails.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return EmailItem(
                                                                  email: emails[
                                                                      index]);
                                                            },
                                                          ),
                                              );
                                      }));
                                }),
                          ],
                        ),
                        Padding(
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
                                        title: 'Send Email',
                                        titleStyle: redHatMediumStyle(
                                            color: darkGray, fontSize: 28),
                                        content: Column(
                                          children: [
                                            Row(
                                              children: [],
                                            )
                                          ],
                                        ));
                                  },
                                  text: 'Send Email'),
                              SizedBox(
                                height: Responsive.isDesktop(context) ? 28 : 16,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class PickReportsOrEmails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ReportsAndEmailsController(),
        builder: (ReportsAndEmailsController reportsAndEmailsController) {
          return Row(
            children: [
              ClicableText(
                text: 'Reports',
                style: redHatMediumStyle(
                    color: reportsAndEmailsController.isReports.value
                        ? purple
                        : gray,
                    fontSize: Responsive.isDesktop(context)
                        ? 24
                        : Responsive.isTablet(context)
                            ? 20
                            : 16),
                function: reportsAndEmailsController.selectReports,
                activeLine: true,
                lineColor: reportsAndEmailsController.isReports.value
                    ? lightPurple
                    : lightGray,
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
                text: 'Emails',
                style: redHatMediumStyle(
                    color: reportsAndEmailsController.isEmails.value
                        ? purple
                        : gray,
                    fontSize: Responsive.isDesktop(context)
                        ? 24
                        : Responsive.isTablet(context)
                            ? 20
                            : 16),
                function: reportsAndEmailsController.selectEmails,
                activeLine: true,
                lineColor: reportsAndEmailsController.isEmails.value
                    ? lightPurple
                    : lightGray,
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

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/view/screens/your-school/daily-check-screen.dart';
import 'package:school_management_system/view/screens/your-school/your_school_controller.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';
import 'package:school_management_system/view/utils/constants/responsive.dart';
import 'package:school_management_system/view/utils/widgets/submit_button.dart';
import 'package:school_management_system/view/utils/widgets/week-day.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../utils/widgets/header.dart';

class YourSchoolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: GetBuilder(
        init: YourSchoolController(),
        builder: (YourSchoolController schoolController) {
          return !schoolController.dailyCheck.value
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: defaultPadding,
                      bottom: defaultPadding,
                      right: defaultPadding,
                      left: defaultPadding * 2,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: Responsive.isDesktop(context)
                                ? defaultPadding * 3
                                : Responsive.isTablet(context)
                                    ? defaultPadding * 2
                                    : defaultPadding,
                            bottom: Responsive.isDesktop(context)
                                ? defaultPadding * 3
                                : Responsive.isTablet(context)
                                    ? defaultPadding * 2
                                    : defaultPadding,
                          ),
                          child: Header(
                            text: 'Your School',
                            size: size,
                          ),
                        ),
                        Responsive(
                          desktop: Row(
                            children: [
                              MyCalender(),
                              SizedBox(
                                  width: (size.width > 1250)
                                      ? size.width * 0.09
                                      : size.width * 0.03),
                              MyClock(),
                            ],
                          ),
                          tablet: Row(
                            children: [
                              MyCalender(),
                              SizedBox(
                                width: (size.width > 950)
                                    ? size.width * 0.125
                                    : (size.width > 875)
                                        ? size.width * 0.05
                                        : 0.03,
                              ),
                              MyClock(),
                            ],
                          ),
                          mobile: Column(
                            children: [
                              MyCalender(),
                              SizedBox(
                                height: 40,
                              ),
                              MyClock(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Responsive.isMobile(context) ? 40 : 80,
                        ),
                        SizedBox(
                          height: Responsive.isMobile(context) ? 88 : 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubmitButton(text: 'Active Days', press: () {}),
                              SizedBox(
                                width: Responsive.isMobile(context) ? 32 : 40,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      WeekDay(
                                        text: 'Sat',
                                        isSelected: (DateFormat('EEEE')
                                                    .format(DateTime.now()) ==
                                                'Saturday')
                                            ? schoolController.updateDay()
                                            : schoolController.unUpdateDay(),
                                        onPress: schoolController.itsToday.value
                                            ? () {
                                                schoolController
                                                    .startDailyCheck();
                                              }
                                            : null,
                                      ),
                                      WeekDay(
                                        text: 'Sun',
                                        isActiveDay: true,
                                        isSelected: (DateFormat('EEEE')
                                                    .format(DateTime.now()) ==
                                                'Sunday')
                                            ? schoolController.updateDay()
                                            : schoolController.unUpdateDay(),
                                        onPress: schoolController.itsToday.value
                                            ? () {
                                                schoolController
                                                    .startDailyCheck();
                                              }
                                            : null,
                                      ),
                                      WeekDay(
                                        text: 'Mon',
                                        isActiveDay: true,
                                        isSelected: (DateFormat('EEEE')
                                                    .format(DateTime.now()) ==
                                                'Monday')
                                            ? schoolController.updateDay()
                                            : schoolController.unUpdateDay(),
                                        onPress: schoolController.itsToday.value
                                            ? () {
                                                schoolController
                                                    .startDailyCheck();
                                              }
                                            : null,
                                      ),
                                      WeekDay(
                                        text: 'Tue',
                                        isActiveDay: true,
                                        isSelected: (DateFormat('EEEE')
                                                    .format(DateTime.now()) ==
                                                'Tuesday')
                                            ? schoolController.updateDay()
                                            : schoolController.unUpdateDay(),
                                        onPress: schoolController.itsToday.value
                                            ? () {
                                                schoolController
                                                    .startDailyCheck();
                                              }
                                            : null,
                                      ),
                                      WeekDay(
                                        text: 'Wed',
                                        isActiveDay: true,
                                        isSelected: (DateFormat('EEEE')
                                                    .format(DateTime.now()) ==
                                                'Wednesday')
                                            ? schoolController.updateDay()
                                            : schoolController.unUpdateDay(),
                                        onPress: schoolController.itsToday.value
                                            ? () {
                                                schoolController
                                                    .startDailyCheck();
                                              }
                                            : null,
                                      ),
                                      WeekDay(
                                        text: 'Thu',
                                        isActiveDay: true,
                                        isSelected: (DateFormat('EEEE')
                                                    .format(DateTime.now()) ==
                                                'Thursday')
                                            ? schoolController.updateDay()
                                            : schoolController.unUpdateDay(),
                                        onPress: schoolController.itsToday.value
                                            ? () {
                                                schoolController
                                                    .startDailyCheck();
                                              }
                                            : null,
                                      ),
                                      WeekDay(
                                        text: 'Fri',
                                        isSelected: (DateFormat('EEEE')
                                                    .format(DateTime.now()) ==
                                                'Friday')
                                            ? schoolController.updateDay()
                                            : schoolController.unUpdateDay(),
                                        onPress: schoolController.itsToday.value
                                            ? () {
                                                schoolController
                                                    .startDailyCheck();
                                              }
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : DailyCheckScreen(checkController: schoolController);
        },
      ),
    );
  }
}

class MyClock extends StatelessWidget {
  const MyClock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DigitalClock(
      amPmDigitTextStyle: redHatMediumStyle(color: lightPurple, fontSize: 36),
      showSecondsDigit: false,
      areaHeight: 300,
      is24HourTimeFormat: false,
      areaAligment: AlignmentDirectional.center,
      areaDecoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(16),
        shape: BoxShape.circle,
        border: Border.all(color: purple, width: 3),
        color: white,
      ),
      secondDigitDecoration: BoxDecoration(),
      hourMinuteDigitDecoration: BoxDecoration(),
      hourMinuteDigitTextStyle: sfBoldStyle(color: purple, fontSize: 60),
      digitAnimationStyle: Curves.decelerate,
    );
  }
}

class MyCalender extends StatelessWidget {
  const MyCalender({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 360,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: black.withOpacity(0.15),
                blurRadius: 16.r,
                offset: Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(
            12.0,
          ),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TableCalendar(
          rowHeight: 60,
          headerStyle: HeaderStyle(
              titleCentered: true,
              titleTextStyle: redHatMediumStyle(fontSize: 24, color: purple),
              formatButtonVisible: false,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: lightPurple,
                size: 28,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: lightPurple,
                size: 28,
              )),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: redHatMediumStyle(fontSize: 16, color: darkGray),
              weekendStyle: redHatMediumStyle(fontSize: 16, color: gray)),
          firstDay: DateTime.utc(2022, 7, 1),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          shouldFillViewport: true,
          daysOfWeekHeight: 24,
          calendarStyle: CalendarStyle(
            defaultTextStyle: redHatRegularStyle(
              fontSize: 16,
            ),
            weekendTextStyle: redHatRegularStyle(
              fontSize: 16,
            ),
            todayTextStyle: redHatMediumStyle(fontSize: 16, color: white),
            todayDecoration:
                BoxDecoration(gradient: gradientColor, shape: BoxShape.circle),
            holidayTextStyle: redHatRegularStyle(
              fontSize: 16,
            ),
            outsideTextStyle: redHatRegularStyle(fontSize: 16, color: gray),
            disabledTextStyle: redHatRegularStyle(
              fontSize: 16,
            ),
            rangeEndTextStyle: redHatRegularStyle(
              fontSize: 16,
            ),
            selectedTextStyle: redHatRegularStyle(
              fontSize: 16,
            ),
            rangeStartTextStyle: redHatRegularStyle(
              fontSize: 16,
            ),
            withinRangeTextStyle: redHatRegularStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

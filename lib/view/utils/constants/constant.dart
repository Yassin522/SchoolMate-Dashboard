import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const defaultPadding = 16.0;
const purple = Color(0xFF636CEF);
const lightPurple = Color(0xFF939CF5);
const darkPurple = Color(0xFF5153C3); // used Only once
const darkGray = Color(0xFF606060); //The main text color
const gray = Color(0xFFA4A4A4);
const lightGray = Color(0xFFD4D4D4);
const black = Color(
    0xFF333333); //used only once I guess, in the Subject Widejt "The total number of lessons at the top"
const blue = Color(0xFF6FA8D7); //used only once
const backgroundColor = Color(0xFFEEEEEE);
const red = Color(0xFFE93030);
const white = Color(0xFFFFFFFF);
const gradientColor = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    lightPurple,
    purple,
  ],
);
const MaterialColor lightPurpleSwatch = MaterialColor(0xFF939CF5, <int, Color>{
  50: Color(0xFFE3F2FD),
  100: Color(0xFFBBDEFB),
  200: Color(0xFF90CAF9),
  300: Color(0xFF64B5F6),
  400: Color(0xFF42A5F5),
  500: Color(0xFF939CF5),
  600: Color(0xFF1E88E5),
  700: Color(0xFF1976D2),
  800: Color(0xFF1565C0),
  900: Color(0xFF0D47A1)
});
BoxDecoration myDecoration = BoxDecoration(
    gradient: gradientColor,
    boxShadow: [
      BoxShadow(
          color: black.withOpacity(0.15),
          blurRadius: 12.r,
          offset: Offset(0, 3))
    ],
    borderRadius: BorderRadius.circular(16));
    String background = 'assets/images/background.png';
  String controlBackground = 'assets/images/control-background.png';

class Pics {
        // String background2 = 'assets/images/background2.jpg';

}

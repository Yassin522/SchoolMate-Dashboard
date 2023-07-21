import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:school_management_system/view/bindings/login-binding.dart';
import 'package:school_management_system/view/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';
import 'package:school_management_system/view/utils/constants/font_families.dart';
import 'package:school_management_system/view/utils/constants/font_style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBrqsWGI_6CrOkZnG1qTM7CiUcpWUtv2Rw',
        appId: '1:276187423017:web:80c7522672521d86f11738',
        messagingSenderId: '276187423017',
        projectId: 'school-management-system-6b1c2',
        storageBucket: 'school-management-system-6b1c2.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    const MyApp(),
    
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: () => GetMaterialApp(
        title: 'SchoolMate',
        theme: ThemeData(
            fontFamily: RedHatDisplay.light,
            backgroundColor: purple,
            primarySwatch: lightPurpleSwatch,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: white,
              
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(color: lightGray, width: 3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(color: lightPurple, width: 3),
              ),
              // floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: redHatMediumStyle(color: gray, fontSize: 24),
            )),
        initialRoute: AppPages.login,
        initialBinding: LoginBinding(),
        getPages: AppPages.pages,
        debugShowCheckedModeBanner: false,
       builder: EasyLoading.init(),
      ),
    );
  }
}

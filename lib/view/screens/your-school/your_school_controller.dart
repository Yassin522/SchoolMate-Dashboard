import 'package:get/get.dart';

class YourSchoolController extends GetxController{
  var itsToday=false.obs;
  var dailyCheck=false.obs;
  // var isExist=true.obs;
void startDailyCheck(){
  dailyCheck.value=true;
  update();
}
void endDailyCheck(){
  dailyCheck.value=false;
  update();
}

  bool updateDay(){
    itsToday.value=true;
    update();
    return itsToday.value;
    
  }
   bool unUpdateDay(){
    itsToday.value=false;
        update();
    return itsToday.value;
  }
}
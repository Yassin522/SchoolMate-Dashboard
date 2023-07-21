import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';

class CheckExistingBox extends StatelessWidget {
  CheckExistingBox({this.value = false,this.press=null});
  var value;
  var press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: 25,
        width: 25,
        decoration: value
            ? BoxDecoration(gradient: gradientColor)
            : BoxDecoration(border: Border.all(color: gray), color: white),
            child:Center(child: Icon(value?Icons.check:Icons.close,color: white,)),
      ),
    );
  }
}

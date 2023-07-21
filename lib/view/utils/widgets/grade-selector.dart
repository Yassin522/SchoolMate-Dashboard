import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:school_management_system/view/screens/grades/grades-controller.dart';


class GradeSelector extends StatelessWidget {
  GradeSelector(
      {required this.options,
      required this.selectedOption,
      required this.selectedOptionList});
  List<String> options;
  Rx<List<String>> selectedOptionList;
  var selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropDownMultiSelect(
      options: options,
      whenEmpty: 'Grade',
      onChanged: (value) {
        selectedOptionList.value = value;
        selectedOption.value = '';
        selectedOptionList.value.forEach((element) {
          selectedOption.value =
              selectedOption.value + ' ' + element;
        });
      },
      selectedValues: selectedOptionList.value,
    );
  }
}

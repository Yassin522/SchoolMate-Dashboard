import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/models/subject.dart';

import '../../../models/grades.dart';

class GradeApi {
  static List<String> allSubjectsid = [];
 
  getGrades() async {
    List allgrades = [];

    var numberofClasses = 0;
    var numberofStudents = 0;
    final grades = await FirebaseFirestore.instance
        .collection('acadimic_year')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        await FirebaseFirestore.instance
            .collection('class-room')
            .where('acadimic_year', isEqualTo: value.docs[i]['grade'])
            .get()
            .then((QuerySnapshot querySnapshot) {
          numberofClasses = querySnapshot.docs.length;
        });

        await FirebaseFirestore.instance
            .collection('students')
            .where('grade', isEqualTo: value.docs[i]['grade'])
            .get()
            .then((QuerySnapshot querySnapshot) {
          numberofStudents = querySnapshot.docs.length;
        });

        allgrades.add(
          Grade(
            name: value.docs[i]['grade'],
            numberofclasses: numberofClasses,
            numberofstudents: numberofStudents,
          ),
        );
      }
    });
    print(allgrades);
    print("sdfsdfsd");

    return allgrades;
  }

  static addgradeapi(
      String name, String fees, List<String> selectedSubjects) async {
    List<String> allSubjectsselid = [];
    print("vvvvvvvvvvvvv");
    print(selectedSubjects);

    await Future.forEach(selectedSubjects, (item) async {
      print(item);
      await FirebaseFirestore.instance
          .collection('subject')
          .where('name', isEqualTo: item)
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          print(
            value.docs[i]['id'],
          );
          String elem = value.docs[i]['id'].toString();
          allSubjectsselid.add(elem);
        }
      });
    });

    print('wait');
    print(allSubjectsselid);

    final data = {
      "grade": int.parse(name),
      "fees": int.parse(fees),
      "subject": allSubjectsselid,
    };

    await FirebaseFirestore.instance
        .collection("acadimic_year")
        .doc(name)
        .set(data)
        .then((value) => print("okkkkkkkkkk"));

    print("allSubjectsselid");
    print(allSubjectsselid);
  }

  static deleteGrade(var name) async {
    await FirebaseFirestore.instance
        .collection("acadimic_year")
        .doc(name.toString())
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  static getMySubjects(String selectedGrade) async {
    List<String> allSubjectsname = [];
    await FirebaseFirestore.instance
        .collection('subject')
        .where('subject_grade', isEqualTo: selectedGrade)
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        allSubjectsid.add(
          value.docs[i]['id'],
        );
        allSubjectsname.add(
          value.docs[i]['name'],
        );
      }
    });

    print("subjects done");
    print(allSubjectsname);
    return allSubjectsname;
  }

  static getGradesOptions() async {
    List<String> allgradesoptions = [];
    await FirebaseFirestore.instance
        .collection('acadimic_year')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        allgradesoptions.add(
          value.docs[i]['grade'].toString(),
        );
      }
    });

    return allgradesoptions;
  }
}

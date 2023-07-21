import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/models/classes.dart';

import '../../../models/grades.dart';

class ClassesApi {
  static List<String> allTeachersid = [];
  static getClasses() async {
    List allClasses = [];

    await FirebaseFirestore.instance
        .collection('class-room')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        var numberofStudents = 0;
        String docID;
        String uid = value.docs[i]['uid'];
        await FirebaseFirestore.instance
            .collection('students')
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            print("gettttttttttttttt");
            if (value.docs[i]['class_id'] == uid) {
              numberofStudents = numberofStudents + 1;
            }
          }
        });
        allClasses.add(
          Classes(
            id: value.docs[i]['uid'],
            name: value.docs[i]['section'],
            studentsNumber: numberofStudents,
          ),
        );
      }
    });

    return allClasses;
  }

  static getNewClasses(List<String> selgrades) async {
    List selallClasses = [];

    for (var i = 0; i < selgrades.length; i++) {
      await FirebaseFirestore.instance
          .collection('class-room')
          .where('acadimic_year', isEqualTo: selgrades[i])
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          var numberofStudents = 0;
          String docID;
          String uid = value.docs[i]['uid'];
          await FirebaseFirestore.instance
              .collection('students')
              .get()
              .then((value) async {
            for (var i = 0; i < value.docs.length; i++) {
              print("gettttttttttttttt");
              if (value.docs[i]['class_id'] == uid) {
                numberofStudents = numberofStudents + 1;
              }
            }
          });
          selallClasses.add(
            Classes(
              id: value.docs[i]['uid'],
              name: value.docs[i]['section'],
              studentsNumber: numberofStudents,
            ),
          );
        }
      });
    }

    print("object");
    print(selallClasses);
    return selallClasses;
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

  static addclassapi(String acadimicyear, String section,
      List<String> selectedTeachers) async {
    List<String> allTeachersselid = [];
    var numberofStudents = 0;

    print("ttttttttttttttt");
    print(selectedTeachers);

    await Future.forEach(selectedTeachers, (item) async {
      print(item);
      String str = item.toString();

      //split string
      var arr = str.split(' ');

      print(arr);

      await FirebaseFirestore.instance
          .collection('teacher')
          .where('first_name', isEqualTo: arr[0])
          .where("last_name", whereIn: [arr[1]])
          .get()
          .then((value) async {
            for (var i = 0; i < value.docs.length; i++) {
              print(
                value.docs[i]['uid'],
              );
              String elem = value.docs[i]['uid'].toString();
              allTeachersselid.add(elem);
            }
          });
    });

    print('wait');
    print(allTeachersselid);

    final data = {
      "acadimic_year": acadimicyear,
      "section": section,
      "teachers": allTeachersselid,
      "uid": "null",
      "number_of_students": 0,
    };

    await FirebaseFirestore.instance
        .collection("class-room")
        .add(data)
        .then((documentSnapshot) async {
      print("Added Data with ID: ${documentSnapshot.id}");
      final data2 = {
        "uid": documentSnapshot.id,
      };
      await FirebaseFirestore.instance
          .collection('class-room')
          .doc(documentSnapshot.id)
          .update(data2);
    });
  }

  static getTeachersOptions() async {
    List<String> allteachersoptions = [];
    await FirebaseFirestore.instance
        .collection('teacher')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        allteachersoptions.add(
          value.docs[i]['first_name'] + ' ' + value.docs[i]['last_name'],
        );
        allTeachersid.add(
          value.docs[i]['uid'],
        );
      }
    });

    return allteachersoptions;
  }

  static deleteGrade(var name) async {
    String? classid;
    await FirebaseFirestore.instance
        .collection("class-room")
        .where('section', isEqualTo: name)
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        classid = value.docs[i]['uid'];
      }
    });

    await FirebaseFirestore.instance
        .collection("class-room")
        .doc(classid)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}

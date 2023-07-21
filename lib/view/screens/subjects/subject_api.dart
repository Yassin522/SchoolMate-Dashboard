import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/models/subject.dart';

class SubjectApi {
  static getClassroomOptions(String? grade) async {
    List<String> allclassesoptions = [];

    try {
      await FirebaseFirestore.instance
          .collection('class-room')
          .where('acadimic_year', isEqualTo: grade)
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          allclassesoptions.add(
            value.docs[i]['section'].toString(),
          );
        }
      });
    } catch (e) {
      print(e);
      print('plz work');
    }
    print(allclassesoptions);

    return allclassesoptions;
  }

  static addsubjectapi(
      String grade, String name, List<String> selectedTeachers) async {
    List<String> allTeachersselid = [];
    var numberofStudents = 0;

    print("sssssssssssssss");
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
      "subject_grade": grade,
      "name": name,
      "teachers": allTeachersselid,
      "id": "null",
    };

    await FirebaseFirestore.instance
        .collection("subject")
        .add(data)
        .then((documentSnapshot) async {
      print("Added Data with ID: ${documentSnapshot.id}");
      final data2 = {
        "id": documentSnapshot.id,
      };
      await FirebaseFirestore.instance
          .collection('subject')
          .doc(documentSnapshot.id)
          .update(data2);
    });
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

  static getSubjects() async {
    List allSubjects = [];
    List allteachersname = [];

    await FirebaseFirestore.instance
        .collection('subject')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        allteachersname = [];
        bool ok2 = false;
        await FirebaseFirestore.instance
            .collection('relation')
            .where('subject', isEqualTo: value.docs[i]['id'])
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            ok2 = true;
            allteachersname.add(
              value.docs[i]['teacher_name'],
            );
          }
        });

        print(allteachersname);
        if (!ok2) {
          allteachersname = ['No teachers'];
        }

        allSubjects.add(
          Subject(
            id: value.docs[i]['id'],
            name: value.docs[i]['name'],
            grade: value.docs[i]['subject_grade'],
            teachers: value.docs[i]['teacher'],
            teachersname: allteachersname,
          ),
        );
      }
    });

    return allSubjects;
  }

  static getNewSubjects(List<String> selgrades) async {
    List selallSubjects = [];

    for (var i = 0; i < selgrades.length; i++) {
      await FirebaseFirestore.instance
          .collection('subject')
          .where('subject_grade', isEqualTo: selgrades[i])
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          selallSubjects.add(
            Subject(
              id: value.docs[i]['id'],
              name: value.docs[i]['name'],
              grade: value.docs[i]['subject_grade'],
            ),
          );
        }
      });
    }

    print("object");
    print(selallSubjects);
    return selallSubjects;
  }
}

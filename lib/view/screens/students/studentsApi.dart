import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management_system/models/student.dart';

class StudentApi {
  static addingStudent(
    String firstName,
    String lastName,
    String email,
    String phone,
    String fatherName,
    String motherName,
    String parentphone,
    String parentemail,
    String paidfees,
    String grade,
    String classroom,
    String password,
  ) async {
    bool isExist = false;
    String? docid;

    await FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      print(value.docs.length);
      print("bruhhhhh");
      if (value.docs.length >= 1) {
        isExist = true;
      }
      for (var i = 0; i < value.docs.length; i++) {
        print(
          value.docs[i]['uid'],
        );
        docid = value.docs[i]['uid'];
      }
    });

    print(isExist);

    if (isExist) {
      String? classid;
      String? section;
      await FirebaseFirestore.instance
          .collection('class-room')
          .where('section', isEqualTo: classroom)
          .where('acadimic_year', whereIn: [grade])
          .get()
          .then((value) async {
            for (var i = 0; i < value.docs.length; i++) {
              print(
                value.docs[i]['uid'],
              );
              classid = value.docs[i]['uid'];
              section = value.docs[i]['section'];
              print(classid);
            }
          });

      final data = {
        "class_id": classid,
        "class_name": section,
        "grade": grade,
        "email": email,
        "father_name": fatherName,
        "fees": int.parse(paidfees),
        "first_name": firstName,
        "last_name": lastName,
        "mother_name": motherName,
        "parent_email": parentemail,
        "parent_phone": parentphone,
        "phone": int.parse(phone),
      };

      await FirebaseFirestore.instance
          .collection("students")
          .doc(docid)
          .update(data);
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }

      String? classid;
      String? section;
      await FirebaseFirestore.instance
          .collection('class-room')
          .where('section', isEqualTo: classroom)
          .where('acadimic_year', whereIn: [grade])
          .get()
          .then((value) async {
            for (var i = 0; i < value.docs.length; i++) {
              print(
                value.docs[i]['uid'],
              );
              classid = value.docs[i]['uid'];
              section = value.docs[i]['section'];
              print(classid);
            }
          });

      final data = {
        "class_id": classid,
        "class_name": section,
        "grade": grade,
        "uid": "null",
        "email": email,
        "father_name": fatherName,
        "fees": int.parse(paidfees),
        "first_name": firstName,
        "grade_average": 0,
        "last_name": lastName,
        "mother_name": motherName,
        "parent_email": parentemail,
        "parent_phone": parentphone,
        "phone": int.parse(phone),
        "urlAvatar":
            "https://media.istockphoto.com/vectors/profile-anonymous-face-icon-gray-silhouette-person-male-default-vector-id903053114?k=6&m=903053114&s=612x612&w=0&h=WrxfHICcs-EyJt0IuX6J35f4lF0p4y1Bsy4AlVYeawY=",
        "token": "nothing",
      };

      await FirebaseFirestore.instance
          .collection("students")
          .add(data)
          .then((documentSnapshot) async {
        print("Added Data with ID: ${documentSnapshot.id}");

        final data2 = {
          "uid": documentSnapshot.id,
        };
        await FirebaseFirestore.instance
            .collection('students')
            .doc(documentSnapshot.id)
            .update(data2);
      });
    }
  }

  static getStudents(String firstName) async {

    if(firstName.isEmpty){
    List allStudents = [];

    await FirebaseFirestore.instance
        .collection('students')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        String? section;

        await FirebaseFirestore.instance
            .collection('class-room')
            .where('uid', isEqualTo: value.docs[i]['class_id'])
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            section = value.docs[i]['section'];
          }
        });

        allStudents.add(
          Student(
            firstName: value.docs[i]['first_name'],
            lastName: value.docs[i]['last_name'],
            studentClass: section,
            studentGrade: value.docs[i]['grade'].toString(),
            fees: value.docs[i]['fees'].toString(),
            average: value.docs[i]['grade_average'].toString(),
            parentPhone: value.docs[i]['parent_phone'].toString(),
            email: value.docs[i]['email'].toString(),
            fatherName: value.docs[i]['father_name'].toString(),
            motherName: value.docs[i]['mother_name'].toString(),
            parentEmail: value.docs[i]['parent_email'].toString(),
            phone: value.docs[i]['phone'].toString(),
          ),
        );
      }
    });

    return allStudents;
    }
    else{
      List allStudents = [];

    await FirebaseFirestore.instance
        .collection('students')
        .where('first_name',isEqualTo: firstName)
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        String? section;

        await FirebaseFirestore.instance
            .collection('class-room')
            .where('uid', isEqualTo: value.docs[i]['class_id'])
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            section = value.docs[i]['section'];
          }
        });

        allStudents.add(
          Student(
            firstName: value.docs[i]['first_name'],
            lastName: value.docs[i]['last_name'],
            studentClass: section,
            studentGrade: value.docs[i]['grade'].toString(),
            fees: value.docs[i]['fees'].toString(),
            average: value.docs[i]['grade_average'].toString(),
            parentPhone: value.docs[i]['parent_phone'].toString(),
            email: value.docs[i]['email'].toString(),
            fatherName: value.docs[i]['father_name'].toString(),
            motherName: value.docs[i]['mother_name'].toString(),
            parentEmail: value.docs[i]['parent_email'].toString(),
            phone: value.docs[i]['phone'].toString(),
          ),
        );
      }
    });

    return allStudents;
    }
  }


  static getsearchStudents(String firstName)async{
     List allStudents = [];

    await FirebaseFirestore.instance
        .collection('students')
        .where('first_name',isEqualTo: firstName)
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        String? section;

        await FirebaseFirestore.instance
            .collection('class-room')
            .where('uid', isEqualTo: value.docs[i]['class_id'])
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            section = value.docs[i]['section'];
          }
        });

        allStudents.add(
          Student(
            firstName: value.docs[i]['first_name'],
            lastName: value.docs[i]['last_name'],
            studentClass: section,
            studentGrade: value.docs[i]['grade'].toString(),
            fees: value.docs[i]['fees'].toString(),
            average: value.docs[i]['grade_average'].toString(),
            parentPhone: value.docs[i]['parent_phone'].toString(),
            email: value.docs[i]['email'].toString(),
            fatherName: value.docs[i]['father_name'].toString(),
            motherName: value.docs[i]['mother_name'].toString(),
            parentEmail: value.docs[i]['parent_email'].toString(),
            phone: value.docs[i]['phone'].toString(),
          ),
        );
      }
    });

    return allStudents;
  }

  static getNewStudents(String grade, String clasroom) async {
    List allStudents = [];

    if (clasroom == 'Class' || clasroom == 'Nothing') {
      await FirebaseFirestore.instance
          .collection('students')
          .where('grade', isEqualTo: int.parse(grade))
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          String? section;

          await FirebaseFirestore.instance
              .collection('class-room')
              .where('uid', isEqualTo: value.docs[i]['class_id'])
              .get()
              .then((value) async {
            for (var i = 0; i < value.docs.length; i++) {
              section = value.docs[i]['section'];
            }
          });

          allStudents.add(
            Student(
              firstName: value.docs[i]['first_name'],
              lastName: value.docs[i]['last_name'],
              studentClass: section,
              studentGrade: value.docs[i]['grade'].toString(),
              fees: value.docs[i]['fees'].toString(),
              average: value.docs[i]['grade_average'].toString(),
              parentPhone: value.docs[i]['parent_phone'].toString(),
              email: value.docs[i]['email'].toString(),
              fatherName: value.docs[i]['father_name'].toString(),
              motherName: value.docs[i]['mother_name'].toString(),
              parentEmail: value.docs[i]['parent_email'].toString(),
              phone: value.docs[i]['phone'].toString(),
            ),
          );
        }
      });

      return allStudents;
    } else {
      await FirebaseFirestore.instance
          .collection('students')
          .where('grade', isEqualTo: int.parse(grade))
          .where('class_name', isEqualTo: clasroom)
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          String? section;

          await FirebaseFirestore.instance
              .collection('class-room')
              .where('uid', isEqualTo: value.docs[i]['class_id'])
              .get()
              .then((value) async {
            for (var i = 0; i < value.docs.length; i++) {
              section = value.docs[i]['section'];
            }
          });

          allStudents.add(
            Student(
              firstName: value.docs[i]['first_name'],
              lastName: value.docs[i]['last_name'],
              studentClass: section,
              studentGrade: value.docs[i]['grade'].toString(),
              fees: value.docs[i]['fees'].toString(),
              average: value.docs[i]['grade_average'].toString(),
              parentPhone: value.docs[i]['parent_phone'].toString(),
              email: value.docs[i]['email'].toString(),
              fatherName: value.docs[i]['father_name'].toString(),
              motherName: value.docs[i]['mother_name'].toString(),
              parentEmail: value.docs[i]['parent_email'].toString(),
              phone: value.docs[i]['phone'].toString(),
            ),
          );
        }
      });

      return allStudents;
    }
  }
}

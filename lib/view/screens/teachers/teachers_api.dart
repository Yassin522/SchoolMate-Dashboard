import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management_system/models/teacher.dart';
import 'package:school_management_system/view/utils/constants/constant.dart';

class TeachersApi {
  static addingTeacher(
    String firstName,
    String lastName,
    String email,
    String phone,
    String study,
    String specialization,
    String university,
    String graduateYea,
    String password,
  ) async {
    bool isExist = false;
    String? docid;
    await FirebaseFirestore.instance
        .collection('teacher')
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
      final data = {
        "University": university,
        "email": email,
        "first_name": firstName,
        "graduateYear": graduateYea,
        "last_name": lastName,
        "specializtion": specialization,
        "study": study,
        "phone": int.parse(phone),
        "password": password,
      };
      await FirebaseFirestore.instance
          .collection("teacher")
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

      final data = {
        "University": university,
        "email": email,
        "first_name": firstName,
        "graduateYear": graduateYea,
        "last_name": lastName,
        "specializtion": specialization,
        "study": study,
        "phone": int.parse(phone),
        "urlAvatr":
            "https://media.istockphoto.com/vectors/profile-anonymous-face-icon-gray-silhouette-person-male-default-vector-id903053114?k=6&m=903053114&s=612x612&w=0&h=WrxfHICcs-EyJt0IuX6J35f4lF0p4y1Bsy4AlVYeawY=",
        "token": "nothing",
      };

      await FirebaseFirestore.instance
          .collection("teacher")
          .add(data)
          .then((documentSnapshot) async {
        print("Added Data with ID: ${documentSnapshot.id}");

        final data2 = {
          "uid": documentSnapshot.id,
        };
        await FirebaseFirestore.instance
            .collection('teacher')
            .doc(documentSnapshot.id)
            .update(data2);
      });
    }
  }

  static getTeachers() async {
    List allTeachers = [];

    print("yesssssssssssssssssss");

    await FirebaseFirestore.instance
        .collection('teacher')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        allTeachers.add(
          Teacher(
            id: value.docs[i]['uid'],
            firstName: value.docs[i]['first_name'],
            lastName: value.docs[i]['last_name'],
            phoneNumber: value.docs[i]['phone'],
            email: value.docs[i]['email'],
            study: value.docs[i]['study'],
            specializtion: value.docs[i]['specializtion'],
            university: value.docs[i]['University'],
            graduateYear: value.docs[i]['graduateYear'],
          ),
        );
      }
    });
    print("noooooooooooooooo");
    print(allTeachers);
    return allTeachers;
  }
}

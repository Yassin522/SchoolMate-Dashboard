import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:school_management_system/models/schedule.dart';

import '../../notification/notification.dart';

class SchedulesApi {
  static addingteacher(String teacher, List<String> selclasses, String? grade,
      String? id, String? name) async {
    bool isExist = false;
    String? docid;

    await FirebaseFirestore.instance
        .collection('relation')
        .where('grade', isEqualTo: grade)
        .where('subject', isEqualTo: id)
        .where('teacher_name', isEqualTo: teacher)
        .get()
        .then((value) {
      print(value.docs.length);
      print("bruhhhhh");
      if (value.docs.length >= 1) {
        isExist = true;
      }
      for (var i = 0; i < value.docs.length; i++) {
        print(
          value.docs[i]['id'],
        );
        docid = value.docs[i]['id'];
      }
    });

    print(isExist);

    if (isExist) {
      String? teacherid;
      List classesid = [];
      var arr = teacher.split(' ');
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
              teacherid = value.docs[i]['uid'].toString();
            }
          });

      await Future.forEach(selclasses, (item) async {
        print(item);

        await FirebaseFirestore.instance
            .collection('class-room')
            .where('acadimic_year', isEqualTo: grade)
            .where("section", whereIn: [item])
            .get()
            .then((value) async {
              for (var i = 0; i < value.docs.length; i++) {
                print(
                  value.docs[i]['uid'],
                );
                String elem = value.docs[i]['uid'].toString();
                classesid.add(elem);
              }
            });
      });

      final data = {
        "classrooms": classesid,
        "teacher": teacherid,
        "teacher_name": teacher
      };

      await FirebaseFirestore.instance
          .collection("relation")
          .doc(docid)
          .update(data);
    } else {
      String? teacherid;
      List classesid = [];
      var arr = teacher.split(' ');
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
              teacherid = value.docs[i]['uid'].toString();
            }
          });

      await Future.forEach(selclasses, (item) async {
        print(item);

        await FirebaseFirestore.instance
            .collection('class-room')
            .where('acadimic_year', isEqualTo: grade)
            .where("section", whereIn: [item])
            .get()
            .then((value) async {
              for (var i = 0; i < value.docs.length; i++) {
                print(
                  value.docs[i]['uid'],
                );
                String elem = value.docs[i]['uid'].toString();
                classesid.add(elem);
              }
            });
      });

      print("i will do it");
      print(id);
      print(teacherid);

      await FirebaseFirestore.instance
          .collection('teacher')
          .doc(teacherid)
          .update({
        "subjects": FieldValue.arrayUnion([id]),
      });

      final data = {
        "classrooms": classesid,
        "grade": grade,
        "subject": id,
        "id": "null",
        "subject_name": name,
        "teacher": teacherid,
        "teacher_name": teacher
      };

      await FirebaseFirestore.instance
          .collection("relation")
          .add(data)
          .then((documentSnapshot) async {
        print("Added Data with ID: ${documentSnapshot.id}");
        final data2 = {
          "id": documentSnapshot.id,
        };
        await FirebaseFirestore.instance
            .collection('relation')
            .doc(documentSnapshot.id)
            .update(data2);
      });
    }
  }

  static addNewSchedule(String who, String type, String grade, String classroom,
      String teachername, String url) async {
    if (who == 'classroom') {
      String? classid;
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
              print(classid);
            }
          });

      final data = {
        "class-room": classid,
        "grade": grade,
        "id": "null",
        "type": type,
        "url": url,
        "date": Timestamp.now(),
      };

      await FirebaseFirestore.instance
          .collection("classProgram")
          .add(data)
          .then((documentSnapshot) async {
        print("Added Data with ID: ${documentSnapshot.id}");

        final data2 = {
          "id": documentSnapshot.id,
        };
        await FirebaseFirestore.instance
            .collection('classProgram')
            .doc(documentSnapshot.id)
            .update(data2);
      });

      print("notifcation class");
      print(classid);
      await FirebaseFirestore.instance
          .collection('students')
          .where('class_id', isEqualTo: classid)
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          print(
            value.docs[i]['uid'],
          );
          NotificationApi.sendPushMessage(
              "A new schedule", type, value.docs[i]['token']);
          print("i will do it bruh");
        }
      });
    } else {
      String? teacherid;

      var arr = teachername.split(' ');

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
              teacherid = value.docs[i]['uid'].toString();
            }
          });

      final data = {
        "teacher": teacherid,
        "id": "null",
        "type": type,
        "url": url,
        "date": Timestamp.now(),
      };

      await FirebaseFirestore.instance
          .collection("teacherProgram")
          .add(data)
          .then((documentSnapshot) async {
        print("Added Data with ID: ${documentSnapshot.id}");

        final data2 = {
          "id": documentSnapshot.id,
        };
        await FirebaseFirestore.instance
            .collection('teacherProgram')
            .doc(documentSnapshot.id)
            .update(data2);
      });

      await FirebaseFirestore.instance
          .collection('teacher')
          .where('uid', isEqualTo: teacherid)
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          print(
            value.docs[i]['uid'],
          );
          NotificationApi.sendPushMessage(
              "A new schedule", type, value.docs[i]['token']);
          print("i will do it bruh");
        }
      });
    }
  }

  static getmyWeekly() async {
    List allWeekly = [];
    await FirebaseFirestore.instance
        .collection('teacherProgram')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        String? name;
        await FirebaseFirestore.instance
            .collection('teacher')
            .where('uid', isEqualTo: value.docs[i]['teacher'])
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            name =
                value.docs[i]['first_name'] + ' ' + value.docs[i]['last_name'];
          }
        });

        allWeekly.add(
          Schedule(
            id: value.docs[i]['id'],
            date: value.docs[i]['date'],
            type: value.docs[i]['type'],
            url: value.docs[i]['url'],
            teacher: name,
          ),
        );
      }
    });

    return allWeekly;
  }

  static getmyExam() async {
    List allExam = [];
    await FirebaseFirestore.instance
        .collection('classProgram')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        String? name;
        String? Grade;
        await FirebaseFirestore.instance
            .collection('class-room')
            .where('uid', isEqualTo: value.docs[i]['class-room'])
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            name = value.docs[i]['section'];
            Grade = value.docs[i]['acadimic_year'];
          }
        });

        allExam.add(
          Schedule(
            id: value.docs[i]['id'],
            date: value.docs[i]['date'],
            type: value.docs[i]['type'],
            url: value.docs[i]['url'],
            classroom: name,
            grade: Grade,
          ),
        );
      }
    });

    return allExam;
  }

  static getClassroomOptions(String grade) async {
    List<String> allclassesoptions = [];
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

    return allclassesoptions;
  }

  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static deleteschedule(String? id, String? classroom) async {
    if (classroom == null) {
      print('deleteeeeeee teacherrrrrrrrrrr');
      await FirebaseFirestore.instance
          .collection("teacherProgram")
          .doc(id)
          .delete()
          .then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );
    } else {
      await FirebaseFirestore.instance
          .collection("classProgram")
          .doc(id)
          .delete()
          .then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );
    }
  }
}

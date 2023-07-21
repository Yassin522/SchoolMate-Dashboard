import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/announcements.dart';
import '../../notification/notification.dart';

class AnnouncememtsApi {
  static addAnnouncememtapi(String type, String content, String title,
      String classroom, String grade) async {
    final data = {
      "content": content,
      "title": title,
      "id": "null",
      "type": type,
      "class-room": "null",
      "date": Timestamp.now(),
    };

    await FirebaseFirestore.instance
        .collection("announcement")
        .add(data)
        .then((documentSnapshot) async {
      print("Added Data with ID: ${documentSnapshot.id}");

      if (type == 'All') {
        final data2 = {
          "id": documentSnapshot.id,
        };
        await FirebaseFirestore.instance
            .collection('announcement')
            .doc(documentSnapshot.id)
            .update(data2);

        await FirebaseFirestore.instance
            .collection('teacher')
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            NotificationApi.sendPushMessage(
                "A new announcement for you", title, value.docs[i]['token']);
          }
        });

        await FirebaseFirestore.instance
            .collection('students')
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            NotificationApi.sendPushMessage(
                "A new announcement for you", title, value.docs[i]['token']);
          }
        });
      } else if (type == 'Teachers') {
        final data2 = {
          "id": documentSnapshot.id,
        };
        await FirebaseFirestore.instance
            .collection('announcement')
            .doc(documentSnapshot.id)
            .update(data2);

        await FirebaseFirestore.instance
            .collection('teacher')
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            NotificationApi.sendPushMessage(
                "A new announcement for you", title, value.docs[i]['token']);
          }
        });

        print("i will do it bruh");
      } else {
        String? classid;
        print("gggggggggggggg");
        print(classroom);
        await FirebaseFirestore.instance
            .collection('class-room')
            .where('section', isEqualTo: classroom)
            .where('acadimic_year', isEqualTo: grade)
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            print(
              value.docs[i]['uid'],
            );
            String classid = value.docs[i]['uid'];
            print(classid);

            final data2 = {
              "id": documentSnapshot.id,
              "class-room": classid,
            };
            await FirebaseFirestore.instance
                .collection('announcement')
                .doc(documentSnapshot.id)
                .update(data2);
          }
        });

        print("object");
        print(classid);

        await FirebaseFirestore.instance
            .collection('students')
            .where('class_id', isEqualTo: classid)
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            NotificationApi.sendPushMessage(
                "A new announcement for you", title, value.docs[i]['token']);
          }
        });
      }
    });
  }

  static getNewAnnouncements(List<String> selClasses) async {
    List selallAnnouncements = [];

    for (var i = 0; i < selClasses.length; i++) {
      await FirebaseFirestore.instance
          .collection('announcement')
          .where('type', isEqualTo: 'classroom')
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          selallAnnouncements.add(
            Announcements(
              id: value.docs[i]['id'],
              content: value.docs[i]['content'],
              date: value.docs[i]['date'],
            ),
          );
        }
      });
    }

    print("object");
    print(selallAnnouncements);
    return selallAnnouncements;
  }

  static getAnnouncements() async {
    List allAnnouncememts = [];

    await FirebaseFirestore.instance
        .collection('announcement')
        .where('type', isEqualTo: 'All')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        allAnnouncememts.add(
          Announcements(
            id: value.docs[i]['id'],
            content: value.docs[i]['content'],
            date: value.docs[i]['date'],
            title: value.docs[i]['title'],
          ),
        );
      }
    });

    return allAnnouncememts;
  }

  static getTeachersAnnouncements() async {
    List allTeachersAnnouncememts = [];

    await FirebaseFirestore.instance
        .collection('announcement')
        .where('type', isEqualTo: 'Teachers')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        allTeachersAnnouncememts.add(
          Announcements(
            id: value.docs[i]['id'],
            content: value.docs[i]['content'],
            date: value.docs[i]['date'],
            title: value.docs[i]['title'],
          ),
        );
      }
    });
    print("teeeeeeeeeee");
    print(allTeachersAnnouncememts[0].content);
    return allTeachersAnnouncememts;
  }

  static getStudentsAnnouncements() async {
    List allStudentsAnnouncememts = [];

    await FirebaseFirestore.instance
        .collection('announcement')
        .where('type', isEqualTo: 'classroom')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        allStudentsAnnouncememts.add(
          Announcements(
            id: value.docs[i]['id'],
            content: value.docs[i]['content'],
            date: value.docs[i]['date'],
            title: value.docs[i]['title'],
          ),
        );
      }
    });
    print("sttttttttttttttttt");
    print(allStudentsAnnouncememts[0].content);
    return allStudentsAnnouncememts;
  }

  static getClassroomOptions() async {
    List<String> allclassesoptions = [];
    await FirebaseFirestore.instance
        .collection('class-room')
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

  static deleteannouncement(String? id) async {
    await FirebaseFirestore.instance
        .collection("announcement")
        .doc(id)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}

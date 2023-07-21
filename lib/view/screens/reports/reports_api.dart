import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/Reports.dart';

class ReportApi {
  static getReports() async {
    List allReports = [];

    await FirebaseFirestore.instance
        .collection('complaint')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        String? fullname;

        await FirebaseFirestore.instance
            .collection('students')
            .where('uid', isEqualTo: value.docs[i]['student'])
            .get()
            .then((value) async {
          for (var i = 0; i < value.docs.length; i++) {
            fullname =
                value.docs[i]['first_name'] + ' ' + value.docs[i]['last_name'];

            print(fullname);
          }
        });

        allReports.add(
          Report(
            id: value.docs[i]['uid'],
            title: value.docs[i]['title'],
            date: value.docs[i]['date'],
            contain: value.docs[i]['content'],
            senderName: fullname,
          ),
        );
      }
    });
    print(allReports);

    return allReports;
  }
}

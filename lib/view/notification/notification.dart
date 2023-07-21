
import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificationApi{

   static sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAQE4NoSk:APA91bEczYqDFjpz6_EPghaa6rIQlVQMhwAzK1WGMgxqupcOYvaqhEDrorp-qiw95BxHoztknovhyftDwtr4ZgYeZPo4wWI6Oo3tlxiSarvHi1BR7Tibrj7rflFFoFQucBxBRWqhz-Y0',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

}
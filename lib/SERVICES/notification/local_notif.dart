// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationApi {
//   static final _notification = FlutterLocalNotificationsPlugin();

//   static Future _notificationDetails() async {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channel id',
//         'channel name',
//         importance: Importance.max
//       ),
//     );
//   }

//   static Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? description,
//     String? payload
//   }) async =>
//     _notification.show(
//       id, 
//       title, 
//       body, 
//       await _notificationDetails(),
//       payload: payload
//     );
// }
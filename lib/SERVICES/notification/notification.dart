// // ignore_for_file: prefer_const_constructors
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:use/UI/Core/notification.dart';
// import 'package:use/main.dart';
// import 'package:flutter/material.dart';

// class NotificationService {
//   static Future <void> initializeNotification() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelGroupKey: 'high_importance_channel',
//           channelKey: 'high_importance_channel',
//           channelName: 'Basic notification',
//           channelDescription: 'Notification channel for basic tests',
//           defaultColor: const Color(0xFF9D50DD),
//           importance: NotificationImportance.Max,
//           channelShowBadge: true,
//           onlyAlertOnce: true,
//           playSound: true,
//           criticalAlerts: true
//         )
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//           channelGroupKey: 'high_importance_channel', 
//           channelGroupName: 'Group 1'
//         )
//       ],
//       debug: true
//     );
    
//     await AwesomeNotifications().isNotificationAllowed().then(
//       (isAllowed) async {
//         if (!isAllowed) {
//           await AwesomeNotifications().requestPermissionToSendNotifications();
//         }
//       }
//     );

//     await AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onActionReceivedMethod,
//       onNotificationCreatedMethod: onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod: onDismissActionReceivedMethod,
//     );
    
//   }

//   static Future <void> onActionReceivedMethod(
//       ReceivedNotification receivedAction) async {
//     debugPrint('onActionReceivedMethod');
//     final payload = receivedAction.payload ?? {};
//     if (payload["navigate"] == "true") {
//       MyApp.navigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (_) => const notif()
//         ),
//       );
//     }
//   }

//   static Future <void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationCreadMethod');
//   }

//   static Future <void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationDisplayedMethod');
//   }

//   static Future <void> onDismissActionReceivedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onDismissActionReceivedMethod');
//   }

//   static Future<void> showNotification({
//     required final String title,
//     required final String body,
//     final String? summary,
//     final Map<String, String>? payload,
//     final ActionType actionType = ActionType.Default,
//     final NotificationLayout notificationLayout = NotificationLayout.Default,
//     final NotificationCategory? category,
//     final String? bigPicture,
//     final List<NotificationActionButton>? actionButtons,
//     final bool scheduled = false,
//     final int? interval,
//   }) async {
//     assert(!scheduled || (scheduled && interval != null));

//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: -1,
//         channelKey: 'high_importance_channel',
//         title: title,
//         body: body,
//         actionType: actionType,
//         notificationLayout: notificationLayout,
//         summary: summary,
//         category: category,
//         payload: payload,
//         bigPicture: bigPicture,
//       ),
//       actionButtons: actionButtons,
//       schedule: scheduled
//           ? NotificationInterval(
//               interval: interval,
//               timeZone:
//                   await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//               preciseAlarm: true,
//             )
//           : null,
//     );
//   }
// }
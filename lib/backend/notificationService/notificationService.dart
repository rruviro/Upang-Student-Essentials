import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  Timer? timer;

  factory NotificationService() {
    return instance;
  }
  

  NotificationService._internal(){
    redirect();
  }
  Future<void> startPolling(int studentId) async {
    print('Starting polling');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastNotificationId = prefs.getInt('last_notification_id') ?? 0;
    final String baseUrl = 'http://10.0.2.2:8000/api/mails';
    
      timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      final response = await http.get(Uri.parse('$baseUrl/$studentId'));

      if (response.statusCode == 200) {
        final List notifications = json.decode(response.body)['mails'];

        for (var notification in notifications) {
          if(notification['isDone'] == 0){
            if (notification['id'] > lastNotificationId) {
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: notification['id'],
                  channelKey: 'basic_channel',
                  title: 'New Notification',
                  body: notification['description'],
                  notificationLayout: NotificationLayout.Default,
                  payload: {
                    'redirectTo': notification['redirectTo'],
                  },
                ),
              );
              await http.put(Uri.parse('http://10.0.2.2:8000/api/notificationdone/${notification['id']}'));
            lastNotificationId = notification['id'];
            await prefs.setInt('last_notification_id', lastNotificationId);
          }}
          
        }
      }
      else{
        print('Failed to fetch notifications: ${response.statusCode} - ${response.body}');
      }
    });
    
  }

  void stopPolling() async {
    print('Stopped polling');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    timer?.cancel(); 
  }

  void redirect() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedNotification) async {
        String? redirectTo = receivedNotification.payload?['redirectTo'];
        switch (redirectTo) {

          case "Announcement":
            print('Redirect to Announcement');
            break;

          case "Claim":
            print('Redirect to Claim');
            break;
          
          case "Request":
            print('Redirect to Request');
            break;

          case "Complete":
            print('Redirect to Complete');
            break;

          case "Cancelled":
            print('Redirect to Cancel');
            break;

          case "Reserve":
            print('Redirect to Reserve');
            break;
          default:
            print("Nothing to do");
        }
      },
    );
  }
}

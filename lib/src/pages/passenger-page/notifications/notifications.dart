import 'package:Fluttaxi/src/pages/passenger-page/pages.dart';
import 'package:Fluttaxi/src/pages/passenger-page/police/police.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => new _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings('splash');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);

  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
//              new RaisedButton(
//                onPressed: _showNotificationWithSound,
//                child: new Text('Show Notification With Sound'),
//              ),
//              new SizedBox(
//                height: 30.0,
//              ),
              new RaisedButton(
                onPressed: _showNotificationWithoutSound,
                child: new Text('Show Notification Without Sound'),
              ),
              new SizedBox(
                height: 30.0,
              ),
//              new RaisedButton(
//                onPressed: _showNotificationWithDefaultSound,
//                child: new Text('Show Notification With Default Sound'),
//              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onSelectNotification(String payload) async {
    print("si entra");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

  // If you have skipped step 4 then Method 1 is not for you

//// Method 1
//  Future _showNotificationWithSound() async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        sound: 'slow_spring_board',
//        importance: Importance.Max,
//        priority: Priority.High);
//    var iOSPlatformChannelSpecifics =
//    new IOSNotificationDetails(sound: "slow_spring_board.aiff");
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//      0,
//      'New Post',
//      'How to Show Notification in Flutter',
//      platformChannelSpecifics,
//      payload: 'Custom_Sound',
//    );
//  }
//// Method 2
//  Future _showNotificationWithDefaultSound() async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High);
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//      0,
//      'New Post',
//      'How to Show Notification in Flutter',
//      platformChannelSpecifics,
//      payload: 'Default_Sound',
//    );
//  }
// Method 3
  Future _showNotificationWithoutSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }
}
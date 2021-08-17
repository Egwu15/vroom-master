import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:vroom_user/Components/snackBar.dart';
import 'package:vroom_user/Locale/locales.dart';
import 'package:vroom_user/Others/Chat/Chats/chats.dart';
import 'package:vroom_user/Others/Chat/NoChatsToShow/no_chats_to_show.dart';
import 'package:vroom_user/Others/FindARide/find_a_ride.dart';
import 'package:vroom_user/Others/Me/me.dart';
import 'package:vroom_user/Others/MyRides/chatHistory.dart';
import 'package:http/http.dart' as http;
import 'package:vroom_user/apis/chatGetController.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:vroom_user/apis/quotation.dart';

import '../main.dart';

class AppNavigation extends StatefulWidget {
  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _currentIndex = 0;
  String _token;
  Stream<String> _tokenStream;

  final List<Widget> _children = [
    Chats(),
    ChatsHistory(),
    // FindARide(),
    // Wallet(),
    Me(),
  ];
  String constructFCMPayload(String token) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': "count",
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#?t) was created via FCM!',
      },
      'to': token,
    });
  }

  @override
  void initState() {
    super.initState();
    void setToken(String token) {
      print('FCM Token: $token');
      setState(() {
        _token = token;
      });
      // checkForQuotaton();
    }
    

    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        // Navigator.pushNamed(context, '/message',
        // arguments: MessageArguments(message, true));
        print("message $message");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message: ${message.notification.title}");
      if (message.notification.title == "Quotation") {
        checkForQuotaton();
      }

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
       if (message.notification.title == "Quotation") {
        checkForQuotaton();
      }
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
    
  }


  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
        }
        break;
      case 'unsubscribe':
        {
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            print('FlutterFire Messaging Example: Getting APNs token...');
            String token = await FirebaseMessaging.instance.getAPNSToken();
            print('FlutterFire Messaging Example: Got APNs token: $token');
          } else {
            print(
                'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
          }
        }
        break;
      default:
        break;
    }
  }

  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer AAAAxR02Itk:APA91bE-s7VfKNbjWLLL1W0Rrzo7KbHuRZmrwumXpNtEACU4T-Zhkk6QB7xihBoFqW-sJjZN2F4U1aKVe5TUzKGhPbhrfJVGA0NwjrPJSDd2XJAt9yVISC10OEu1xSJ3aleHT0EBCyTg',
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ChatDetails chatDetails = Get.put(ChatDetails());
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    final List<BottomNavigationBarItem> _items = [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.chat_rounded,
        ),
        label: locale.chats,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.recent_actors,
        ),
        label: "Chat history",
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(
      //     Icons.search,
      //   ),
      //   label: locale.findARide,
      // ),
      // BottomNavigationBarItem(
      //   icon: Icon(
      //     Icons.account_balance_wallet_rounded,
      //   ),
      //   label: locale.wallet,
      // ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        label: "Me",
      ),
    ];
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 16.0),
            title: Text('Are you sure you want to quit?'),
            actions: <Widget>[
              TextButton(
                  child: Text('sign out'),
                  onPressed: () => Navigator.of(context).pop(true)),
              TextButton(
                  child: Text('cancel'),
                  onPressed: () => Navigator.of(context).pop(false)),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: _items,
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: theme.hintColor,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.shifting,
        ),
      ),
    );
  }
}

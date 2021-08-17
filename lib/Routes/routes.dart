import 'package:flutter/material.dart';
import 'package:vroom_user/AppNavigation/app_navigation.dart';
import 'package:vroom_user/Auth/SignUp/sign_up.dart';
import 'package:vroom_user/Auth/Verification/verification.dart';
import 'package:vroom_user/Others/ChangeLanguage/change_language.dart';
import 'package:vroom_user/Others/Chat/ChatConversation/chat_conversation.dart';
import 'package:vroom_user/Others/Chat/Chats/chats.dart';
import 'package:vroom_user/Others/ConfirmRideRequest/confirmRideRequest.dart';
import 'package:vroom_user/Others/FareRate/fare_rate.dart';
import 'package:vroom_user/Others/FindARide/find_a_ride.dart';
import 'package:vroom_user/Others/Help/help.dart';
import 'package:vroom_user/Others/ListOfRides/list_of_rides.dart';
import 'package:vroom_user/Others/MyProfile/myProfile.dart';
import 'package:vroom_user/Others/Notifications/notifications.dart';
import 'package:vroom_user/Others/ReferNow/refer_now.dart';
import 'package:vroom_user/Others/RideMap/ride_map.dart';
import 'package:vroom_user/Others/RiderProfile/rider_profile.dart';
import 'package:vroom_user/Others/SendToBank/send_to_bank.dart';
import 'package:vroom_user/Others/TermsAndConditions/terms_and_conditions.dart';

class PageRoutes {
  static const String signUp = 'sign_up';
  static const String verification = 'verification';
  static const String findARide = 'findARide';
  static const String listOfRides = 'listOfRides';
  static const String appNavigation = 'appNavigation';
  static const String referNow = 'referNow';
  static const String myProfile = 'myProfile';
  static const String termsAndConditions = 'termsAndConditions';
  static const String help = 'help';
  static const String riderProfile = 'riderProfile';
  static const String confirmRideRequest = 'confirmRideRequest';
  static const String chats = 'chats';
  static const String chatsConversation = 'chatsConversation';
  static const String sendToBank = 'sendToBank';
  static const String rideMap = 'rideMap';
  static const String changeLanguage = 'changeLanguage';
  static const String notifications = 'notifications';
  static const String fareRate = 'fareRate';

  Map<String, WidgetBuilder> routes() {
    return {
      signUp: (context) => SignUpUI(),
      verification: (context) => Verification(),
      findARide: (context) => FindARide(),
      listOfRides: (context) => ListOfRides(),
      appNavigation: (context) => AppNavigation(),
      referNow: (context) => ReferNow(),
      myProfile: (context) => MyProfile(),
      termsAndConditions: (context) => TermsAndConditions(),
      help: (context) => Help(),
      riderProfile: (context) => RiderProfile(),
      confirmRideRequest: (context) => ConfirmRideRequest(),
      chats: (context) => Chats(),
      chatsConversation: (context) => ChatConversation(),
      sendToBank: (context) => SendToBank(),
      rideMap: (context) => RideMap(),
      changeLanguage: (context) => ChangeLanguage(),
      notifications: (context) => Notifications(),
      fareRate: (context) => FareRate(),
    };
  }
}

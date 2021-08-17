import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:vroom_user/AppNavigation/app_navigation.dart';
import 'package:vroom_user/Auth/Verification/otp.dart';
import 'package:vroom_user/Components/snackBar.dart';
import 'package:vroom_user/apis/fireStoreDB.dart';
import 'package:vroom_user/apis/hiveStorage.dart';
import 'package:vroom_user/apis/profileController.dart';
import 'package:vroom_user/models/tokenModel.dart';
import 'package:vroom_user/models/userModel.dart';
import 'package:vroom_user/models/userRegModel.dart';
import 'package:get/instance_manager.dart';

HiveCalls hiveCalls = HiveCalls();
String myPushToken;
Stream<String> _tokenStream;
String baseUrl = "https://tugent.tbmholdingltd.com/api";
int userId;
ProfileController profileController = Get.put(ProfileController());
setPushToken(tok, userId) async {
  await hiveCalls.addPushToken(tok);
  await CloudDB().updatePushToken(tok, userId);
}

signUp({email, password, name, phoneNumber}) async {
  try {
    var url = Uri.parse('$baseUrl/user_registration');
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber
    });
    print(response.body);
    if (response.statusCode == 200) {
      await getUserDetails(userRegisterdModelFromJson(response.body).token);
      await CloudDB().setUserDetails(userid: userId, name: name);
      await hiveCalls
          .addUserToken(userRegisterdModelFromJson(response.body).token);
      await createPushToken(userId);
      Get.to(() => OtpPage());
    } else if (response.statusCode == 422) {
      showCustomSnackBar('email is already used');
    } else {
      showCustomSnackBar('Please check your network and try again');
    }
  } catch (e) {
    print(e);
  }
}

signIn({email, password}) async {
  try {
    var url = Uri.parse('$baseUrl/login');
    var response = await http.post(url,
        body: {'email': email, 'password': password, });
    print(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == "Please verify using Otp ") {
        return Get.to(() => OtpPage());
      } else {
        print((tokenModelFromJson(response.body).token));
        await hiveCalls
            .addUserToken(userRegisterdModelFromJson(response.body).token);
        await getUserDetails(tokenModelFromJson(response.body).token)
            .then((_) async {
          await createPushToken(userId);
          Get.to(
            () => AppNavigation(),
          );
        });
      }
    } else if (response.statusCode == 401) {
      showCustomSnackBar('Wrong username or password');
    } else {
      showCustomSnackBar('Please check your network and try again');
    }
  } catch (e) {
    print(e);
  }
}

getUserDetails(token) async {
  try {
    var url = Uri.parse('$baseUrl/user');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("statuscode: ${response.statusCode}");
    print("body: ${response.body}");
    if (response.statusCode == 201) {
      userId = userModelFromJson(response.body).data.id;
      var userName = userModelFromJson(response.body).data.name;
      var userEmail = userModelFromJson(response.body).data.email;
      var picture = userModelFromJson(response.body).data.avater;
      var active = userModelFromJson(response.body).data.activewithUser;
      var phoneNumber = userModelFromJson(response.body).data.phoneNumber;
      print("userid: $userId");
      await hiveCalls.addUserId(userId);
      profileController.addPicture(picture);
      await hiveCalls.addUserEmail(userEmail);
      await hiveCalls.addUserName(userName);
      await hiveCalls.addProfilePhoto(picture);
      await hiveCalls.addActiveWith(active);
      await hiveCalls.addPhoneNumber(phoneNumber);
      // print('object');
      //   Get.to(
      //     () => AppNavigation(),
      // );
    } else
      Get.to(() => signIn());
  } catch (e) {
    print(e);
  }
}

registerAgentChat({agentId}) async {
  try {
    String token = await hiveCalls.getUserToken();
    var url = Uri.parse('$baseUrl/userChat/${agentId.toString()}');
    print(url);
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("statuscode: ${response.statusCode}");
    // print(response.body);
    print("body: ${response.body}");
    // print(response.body);
    if (response.statusCode == 201) {
      // print("userid: ${userModelFromJson(response.body).data.id}");
      // await hiveCalls.addUserId(userModelFromJson(response.body).data.id);
      // // print('object');
      // //   Get.to(
      // //     () => AppNavigation(),
      // );
    } else
      // Get.to(() => signIn());
      print('elsec ');
  } catch (e) {
    print(e);
  }
}

createPushToken(userId) {
  FirebaseMessaging.instance.getToken().then((tok) {
    setPushToken(tok, userId);
  });
  _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
  _tokenStream.listen((tok) {
    setPushToken(tok, userId);
  });
}

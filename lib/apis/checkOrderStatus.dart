import 'dart:convert';

import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:vroom_user/Auth/Verification/QuotationSucess.dart';
import 'package:vroom_user/Auth/Verification/verificationSucess.dart';
import 'package:vroom_user/Others/Wallet/orderStatus.dart';
import '../AppNavigation/app_navigation.dart';
import '../Components/snackBar.dart';
import '../apis/hiveStorage.dart';
import 'authCall.dart';

checkOrderStatus() async {
  String token = await HiveCalls().getUserToken();
  try {
    var response = await http.get(
      Uri.parse("$baseUrl/getOrder"),
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      if (jsonDecode(response.body)["data"] == null) {
        return showCustomSnackBar("no order status to check!!");
      }
      print(jsonDecode(response.body)["data"]["orderStatus"]);
      Get.to(() => OrderStatusPage(
          orderValue: jsonDecode(response.body)["data"]["orderStatus"]));
    } else {
      showCustomSnackBar("No orders found try again later");
    }
  } on Exception catch (e) {
    print(e);
  }
}

orderDeliverd() async {
  String token = await HiveCalls().getUserToken();
  try {
    var response = await http.get(
      Uri.parse("$baseUrl/delivery"),
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      Get.to(() => AppNavigation());
      showCustomSnackBar("delivery Confirmed");
    } else {
      showCustomSnackBar("Error confirming delivery please try agaim");
    }
  } on Exception catch (e) {
    print(e);
  }
}

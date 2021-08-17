import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vroom_user/Components/quotationPopUp.dart';
import 'package:vroom_user/Components/snackBar.dart';
import 'package:vroom_user/apis/hiveStorage.dart';
import 'package:get/route_manager.dart';
import 'package:vroom_user/apis/authCall.dart';
import 'package:vroom_user/screens/webView.dart';

List emptyList = [];
checkForQuotaton() async {
  try {
    String token = await HiveCalls().getUserToken();
    var url = Uri.parse('$baseUrl/ViewQuotation');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      print(json.decode(response.body)['data']);
      showQuotationPopUp();
    } else {
      return false;
    }
  } catch (e) {
    print(e);
  }
}

acceptQuotaton() async {
  try {
    String token = await HiveCalls().getUserToken();
    var url = Uri.parse('$baseUrl/acceptQuote');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      showCustomSnackBar('You have sucessfully accepted the quote');
    } else {
         Get.back();
      showCustomSnackBar('error accepting quote, try again');
    }
  } catch (e) {
    print(e);
  }
}

declineQuotaton() async {
  try {
    String token = await HiveCalls().getUserToken();
    var url = Uri.parse('$baseUrl/decline');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      showCustomSnackBar('You have sucessfully rejected the quote');
    } else {
         Get.back();
      showCustomSnackBar('error rejecting quote, try again');
    }
  } catch (e) {
    print(e);
  }
}

makePayment() async {
  try {
    String token = await HiveCalls().getUserToken();
    var url = Uri.parse('$baseUrl/pay');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    print(response.statusCode);
    String paymentLink =
        json.decode(response.body)['data']['authorization_url'] ?? '';
    print((json.decode(response.body)['data']['authorization_url']));
    if (response.statusCode == 200) {
      Get.to(() => PaymentWebView(
            paymentUrl: paymentLink,
          ));
    } else if (response.statusCode == 500) {
      // showQuotationPopUp();
      showCustomSnackBar('accept quotation first');
    } else {
      showCustomSnackBar('error');
    }
  } catch (e) {
    print(e);
  }
}

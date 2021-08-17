import 'dart:convert';
import 'package:http/http.dart' as http;

import 'authCall.dart';

getBanks() async {
  try {
    var url = Uri.parse('$baseUrl/getBank');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var resBody = json.decode(response.body);
      print(resBody);
      // final lenght = resBody.length;
      // print("lenght: $lenght");
      // var bank = BankModel.fromJson(await jsonDecode(response.body));
var bank = resBody;
// print("name $bank");
      // Get.to(() => BankScreen(
      //       banks: bank,
      //       email: email,
      //       phoneNumber: phoneNumber,
      //     ));
      // print("bankkx $bank");
      return bank;
    }
    print("online status : ${response.statusCode}");
    // print("online body : ${response.body}");
  } catch (e) {
    print(e);
  }
}

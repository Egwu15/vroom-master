import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import '../AppNavigation/app_navigation.dart';
import '../Components/snackBar.dart';
import '../apis/hiveStorage.dart';
import 'authCall.dart';

checkOtp(otp) async {
  String token = await HiveCalls().getUserToken();
  try {
    var response = await http.post(Uri.parse("$baseUrl/otp"), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      "otp": otp
    });
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      Get.to(() => AppNavigation());
      showCustomSnackBar("Account verified sucessfully!!");
    } else {
      showCustomSnackBar("Incorrect otp");
    }
  } on Exception catch (e) {
    print(e);
  }
}

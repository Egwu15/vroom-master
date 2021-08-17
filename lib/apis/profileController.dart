import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';

class ProfileController extends GetxController {
  var picture = ''.obs;
  addPicture(currentPicture) => picture.value = currentPicture;
}

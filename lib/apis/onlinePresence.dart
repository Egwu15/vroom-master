import 'package:firebase_database/firebase_database.dart';
import 'package:vroom_user/apis/hiveStorage.dart';

class Database {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  updateUserPresence() async {
    Map<String, dynamic> presenceStatusTrue = {
      'isLoggedIn': true,
      // 'last_seen': DateTime.now().millisecondsSinceEpoch,
    };
    String userId = await HiveCalls().getUserId();

    await databaseReference
        .child("users/$userId")
        .update(presenceStatusTrue)
        .whenComplete(() => print('Updated your presence.'))
        .catchError((e) => print(e));

    Map<String, dynamic> presenceStatusFalse = {
      'isLoggedIn': false,
      // 'last_seen': DateTime.now().millisecondsSinceEpoch,
    };

    databaseReference.child("users/$userId").onDisconnect().update(presenceStatusFalse);
  }
}

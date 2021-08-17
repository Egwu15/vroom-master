import 'package:cloud_firestore/cloud_firestore.dart';

class CloudDB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  setUserDetails({userid, name}) {
    firestore.collection('users').doc(userid.toString()).set({
      "id": userid,
      "isLoggedIn": true,
      'name': name,
      'isAgent': false,
      'chatted': []
    });
  }

  setAgentChat({otherId, myId}) {
    firestore.collection('users').doc(myId.toString()).update({
      'chatted': FieldValue.arrayUnion([otherId])
    });
  }
  

    updatePushToken(pushToken, userId) {
    firestore.collection('users').doc(userId.toString()).update({
      "pushToken": pushToken,
    });}
}

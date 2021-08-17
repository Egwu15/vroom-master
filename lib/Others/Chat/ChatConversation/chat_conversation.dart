import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vroom_user/Components/circularImage.dart';
import 'package:vroom_user/Locale/locales.dart';
import 'package:vroom_user/Others/Chat/Chats/chats.dart';
import 'package:vroom_user/Theme/colors.dart';
import 'package:vroom_user/apis/authCall.dart';
import 'package:vroom_user/apis/chatGetController.dart';
import 'package:vroom_user/apis/fireStoreDB.dart';
import 'package:http/http.dart' as http;
import 'package:get/instance_manager.dart';
import 'package:vroom_user/apis/hiveStorage.dart';

class ChatConversation extends StatefulWidget {
  ChatConversation();
  @override
  _ChatConversationState createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation> {
  String groupChatId;
  TextEditingController textEditingController = TextEditingController();
  var format = DateFormat.yMd().add_jm();
  ScrollController scrollController = ScrollController();
  String msg;
    final ChatDetails chatDetails = Get.find();
    int _myID;
    int _otherId;

  @override
  void initState() {
    super.initState();
   
    getGroupId();
  }

  String constructFCMPayload(
    String token,
  ) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': "count",
      },
      'notification': {
        'title': 'Message from...',
        'body': msg,
      },
      'to': token,
    });
  }

  Future<void> sendPushMessage() async {
    if (chatDetails.myID.value == null) {
     
      print('Unable to send FCM message, no token exists.');
      return;
    }

 print('object');
    try {
      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer AAAAxR02Itk:APA91bE-s7VfKNbjWLLL1W0Rrzo7KbHuRZmrwumXpNtEACU4T-Zhkk6QB7xihBoFqW-sJjZN2F4U1aKVe5TUzKGhPbhrfJVGA0NwjrPJSDd2XJAt9yVISC10OEu1xSJ3aleHT0EBCyTg',
        },
        body: constructFCMPayload(chatDetails.pushToken.value),
      );

      print('FCM request for device sent!');
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  getGroupId() async{
     _myID = chatDetails.myID.value;
     _otherId = chatDetails.otherId.value;
    print("myId $_myID");
    print("otherID $_otherId");

    if (_myID > _otherId) {
      groupChatId = '$_myID - $_otherId';
    } else {
      groupChatId = '$_otherId - $_myID';
    }
  }

  sendMsg() {
    msg = textEditingController.text.trim();
    textEditingController.clear();

    print(_myID);
    print(_otherId);

    /// Upload images to firebase and returns a URL
    if (msg.isNotEmpty) {
      print('thisiscalled $msg');
      var ref = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(
            DateTime.now().millisecondsSinceEpoch.toString(),
          );

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(ref, {
          "senderId": _myID,
          "anotherUserId": _otherId,
          "timestamp": DateTime.now().millisecondsSinceEpoch,
          'content': msg,
          "type": 'text',
        });
      });

      sendPushMessage();

      registerAgentChat(agentId: _otherId);

      print(_otherId);
      CloudDB().setAgentChat(otherId: _otherId, myId: _myID);
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
    } else {
      print('Please enter some text to send');
    }
  }

  bool _isMyMessage(myOwnId) {
    if (myOwnId == _myID) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    print(_otherId);
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              child: Icon(Icons.arrow_back_ios_outlined),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 10,
            ),
            circularImage(
                "https://tugent.tbmholdingltd.com/images/${chatDetails.userName.value.trim()}.jpg",
                40.0),
            SizedBox(
              width: 20,
            ),
            Text(
              chatDetails.userName.value,
              style: theme.textTheme.headline6,
            ),
          ],
        ),
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Image.asset(
              'assets/chatBg.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1.4,
              fit: BoxFit.fill,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                          child: ListView.builder(
                        controller: scrollController,
                        itemBuilder: (listContext, index) {
                          var doc = snapshot.data.docs[index];
                          return MessageBubble(
                            isDelivered: true,
                            isMe: _isMyMessage(doc['senderId']),
                            sender: 'jjjd',
                            text: doc['content'],
                            time: format.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  doc['timestamp']),
                            ),
                          );
                        },
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                      )),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () => sendMsg(),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                      child: SizedBox(
                    height: 36,
                    width: 36,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ));
                }
              },
            ),
            PositionedDirectional(
              bottom: 0,
              start: 0,
              end: 0,
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 16, right: 16, top: 15, bottom: 15),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintText: locale.typeYourMessage,
                    hintStyle: theme.textTheme.subtitle2.copyWith(fontSize: 12),
                    fillColor: Color(0xfff8f9fd),
                    suffixIcon:
                        // GestureDetector(
                        //   onTap: sendMsg(),
                        //   child:Icon(
                        //     Icons.send,
                        //     color: theme.primaryColor,
                        //     size: 21,
                        //   ),
                        // ),
                        IconButton(
                      onPressed: () => sendMsg(),
                      icon: Icon(
                        Icons.send,
                        color: theme.primaryColor,
                        size: 21,
                      ),
                    )),
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    List<MessageBubble> messageBubbles = [
      MessageBubble(
        sender: 'user',
        text: locale.heyDavid + '\n' + locale.goodTimeToTalk,
        time: '11:59 am',
        isDelivered: false,
        isMe: true,
      ),
      MessageBubble(
        sender: 'delivery_partner',
        text: locale.heyMate + '\n' + locale.yesTellMe,
        time: '11:58 am',
        isDelivered: false,
        isMe: false,
      ),
      MessageBubble(
        sender: 'user',
        text: locale.whatIsYourRouteFrom + '\n' + 'Washington Sq. Park?',
        time: '11:59 am',
        isDelivered: false,
        isMe: true,
      ),
    ];
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      children: messageBubbles,
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String text;
  final String sender;
  final String time;
  final bool isDelivered;

  MessageBubble(
      {this.sender, this.text, this.time, this.isMe, this.isDelivered});

  @override
  Widget build(
    BuildContext context,
  ) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 4.0,
            color: isMe ? theme.scaffoldBackgroundColor : theme.primaryColor,
            borderRadius: BorderRadius.circular(6.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text,
                    style: isMe
                        ? Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontWeight: FontWeight.w500)
                        : Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: hintTextColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      isMe
                          ? Icon(
                              Icons.check_circle,
                              color:
                                  isDelivered ? Colors.blue : Colors.grey[300],
                              size: 12.0,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

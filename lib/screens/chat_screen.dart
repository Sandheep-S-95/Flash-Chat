import 'package:flash_chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/text_box.dart';

final _firestore=FirebaseFirestore.instance;

User? loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController =TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? messageText;

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser;

      if(user != null){
        setState(() {
            loggedInUser = user;
        });
        print(loggedInUser!.email);
      }
    }catch (e){
      print(e);
    }
  }

  // void getMessages() async{
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs){
  //     print(message.data());
  //   }
  // }

  void messagesStream() async{
    await  for (var snapshot in _firestore.collection('messages').snapshots()){
      for (var message in snapshot.docs){
        print(message.data());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
                //Implement logout functionality
                //_auth.signOut();
                //Navigator.pop(context);

              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller:messageTextController,
                      onChanged: (value) {
                        //
                        messageText= value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                    TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      //email + message text
                      String ? currentUser=loggedInUser?.email;
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        "sender":loggedInUser?.email,
                        "text":messageText,
                        "timestamp": FieldValue.serverTimestamp()
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool isOurUser = true ;
class MessageStream extends StatefulWidget {
  const MessageStream({super.key});

  @override
  State<MessageStream> createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];

            final currentUser = loggedInUser!.email;
            isOurUser = currentUser == messageSender;
            final messageWidget = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe : currentUser==messageSender,
            );
            messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse:true,
              // crossAxisAlignment: isOurUser ? CrossAxisAlignment.end: CrossAxisAlignment.start,
              children:messageWidgets,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}



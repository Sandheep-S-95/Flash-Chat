import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.sender, required this.text,required this.isMe});

  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
          children: [
            Container(width:double.infinity),
            Text(sender,style: TextStyle(color: Colors.black54)),
            Material(
              borderRadius: isMe ?
                BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                :
                 BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
              elevation:5.0,
              color: isMe ? Colors.lightBlueAccent : Colors.white,
              child:Padding(
                padding:EdgeInsets.symmetric(vertical : 10, horizontal : 20),
                child:Text(
                  text,
                  style:TextStyle(
                    color: isMe ? Colors.white : Colors.black54,
                    fontSize: 15.0,
                  )
                )
            )
            ),
          ],
        ),
    );
  }
}


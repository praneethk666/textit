// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:textit/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
late User logginUser;
class ChatScreen extends StatefulWidget {


  static const String id = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final textController = new  TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String  messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser()async{
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        logginUser = user;
        print(logginUser.email);
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('Textit',
          style: GoogleFonts.b612Mono(
            fontWeight: FontWeight.w900,
            color: Color(0xFFF5FCF9),
          ),),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(stream : _firestore.collection('messages').snapshots(),
              builder :( BuildContext context,snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final messages = snapshot.data!.docs.reversed;
              List<MessageBubble> messageBubbles = [];
              for(var message in messages){
                final messageText = message.get('text');
                final messageSender = message.get("sender");
                final currentUser = logginUser.email;

                final messageBubble = MessageBubble(sender:messageSender,text: messageText,isMe: currentUser==logginUser,
                );
                messageBubbles.add(messageBubble);
              }
              return Expanded(
                child: ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                  children : messageBubbles,
                ),
              );
            },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        messageText=value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      textController.clear();
                      _firestore.collection('messages').add
                        ({'text': messageText,
                            'sender':logginUser.email});
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

class MessageBubble extends StatelessWidget {
  const MessageBubble( {required this.sender,required this.text,required this.isMe}) ;

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender,style: TextStyle(
            fontSize: 10.0,
            color : Colors.black54,
          ),),
          Material(
            borderRadius: isMe?BorderRadius.only(topLeft: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)):
            BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),topRight: Radius.circular(30.0)),
            elevation: 6.0,
            color: isMe? Colors.pinkAccent:Colors.purpleAccent,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Text(text,
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


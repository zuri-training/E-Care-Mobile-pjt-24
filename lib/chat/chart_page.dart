import 'package:flutter/material.dart';
import 'models/chatUsersModel.dart';
import 'widgets/conversationList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    //Placeholder values pending actual data
    ChatUsers(
        name: "Dr. Paul",
        messageText: "Hello! How can i help you?",
        imageURL: "assets/images/ellipse14.png",
        time: "14:22",
        messageCount: 2),
    ChatUsers(
        name: "Dr. Rachel",
        messageText: "Thank you for visiting",
        imageURL: "assets/images/ellipse14.png",
        time: "14:22",
        messageCount: 0),
    ChatUsers(
        name: "Dr. James",
        messageText: "I have a bad headache",
        imageURL: "assets/images/ellipse14.png",
        time: "14:22",
        messageCount: 1),
    ChatUsers(
        name: "Dr. Peter",
        messageText: "What was your last meal?",
        imageURL: "assets/images/ellipse14.png",
        time: "14:22",
        messageCount: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 24),
                child: Text(
                  "Chats",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  messageCount: chatUsers[index].messageCount,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

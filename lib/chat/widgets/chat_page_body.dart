import 'package:e_care_mobile/chat/models/chatUsersModel.dart';
import 'package:e_care_mobile/chat/models/convo.dart';
import 'package:e_care_mobile/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'conversationList.dart';

class ChatPageBody extends StatelessWidget {
  final List<Convo> chatUsers;

  const ChatPageBody({
    @required this.chatUsers,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
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
                    receiverId: chatUsers[index].lastMessage['idTo'],
                    name: chatUsers[index].lastMessage['sender'],
                    //firstname + ' ' + chatUsers[index].surname,
                    messageText: chatUsers[index].lastMessage['messageText'],
                    urlAvatar: chatUsers[index].lastMessage['urlAvatar'],
                    time: chatUsers[index].lastMessage['lastMessageTime'],
                    messageCount: chatUsers[index].lastMessage['messageCount'],
                    isMessageRead:
                        chatUsers[index].lastMessage['isMessageRead'],
                    userId: chatUsers[index].lastMessage[
                        'idFrom'] //(index == 0 || index == 3) ? true : false,
                    );
              },
            ),
          ],
        ),
      );
}

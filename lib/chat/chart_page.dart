import 'package:carbon_icons/carbon_icons.dart';
import 'package:e_care_mobile/chat/widgets/chat_page_body.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/screens/patient_dashboard.dart';
import 'package:e_care_mobile/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/chat_api.dart';
import 'models/chatUsersModel.dart';
import 'models/convo.dart';
import 'widgets/conversationList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  /*List<ChatUsers> chatUsers = [
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
  ];*/

  @override
  Widget build(BuildContext context) {
    UserProvider userData = Provider.of<UserProvider>(context);
    return Scaffold(
      body: StreamBuilder<List<Convo>>(
          stream: FirebaseApi.getUsers('60e714688bc25500be0dfa0c'),
          //userData.user.patientId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: loadingSpinner(48.0, 2.0));
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return buildText('Something Went Wrong Try later');
                } else {
                  final chatUsers = snapshot.data;
                  var chat =
                      chatUsers[0].lastMessage['isMessageRead']; //[''].name;
                  print('chatUSers: $chat');

                  if (chatUsers.isEmpty) {
                    return buildText('No Chat Found');
                  } else
                    return ChatPageBody(
                      chatUsers: chatUsers,
                    );
                }
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff6305B1),
        selectedLabelStyle: TextStyle(
          fontSize: 16,
        ),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PatientDashboard()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Icon(
                  CarbonIcons.home,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height / 20,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Icon(
                  CarbonIcons.chat_bot,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height / 20,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(
                CarbonIcons.settings,
                color: Colors.white,
                size: MediaQuery.of(context).size.height / 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

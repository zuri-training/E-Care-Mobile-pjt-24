import 'package:carbon_icons/carbon_icons.dart';
import 'package:e_care_mobile/chat/widgets/chat_page_body.dart';
import 'package:e_care_mobile/screens/patient_dashboard.dart';
import 'package:e_care_mobile/screens/profile/profile_page.dart';
import 'package:e_care_mobile/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'api/chat_api.dart';
import 'models/convo.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
// Colors
  Color _green = HexColor("#4BA54D");

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      if (index == 0) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PatientDashboard()));
      } else if (index == 1) {
        /*Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatPage()));*/
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfilePage()));
      }
    }

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
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: _green,
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
            icon: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(
                CarbonIcons.home,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(
                CarbonIcons.chat_bot,
                color: Colors.white,
                size: 24,
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
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:e_care_mobile/chat/widgets/messages_widget.dart';
import 'package:e_care_mobile/chat/widgets/new_message.dart';
import 'package:e_care_mobile/providers/chat_provider.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'models/chatMessageModel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatDetailPage extends StatefulWidget {
  final String receiverId;
  final String doctorName;
  final String doctorSurname;

  ChatDetailPage(
      {@required this.receiverId,
      @required this.doctorName,
      this.doctorSurname});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  String dropdownValue;
  String firstname;
  String surname;

  @override
  void initState() {
    super.initState();
    List<String> arr = widget.doctorName.split(' ');
    String first = arr[0];
    String last = arr[1];
    setState(() {
      firstname = first;
      surname = last;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userData = Provider.of<UserProvider>(context);
    //Provider.of<ChatProvider>(context, listen: false).setId(widget.receiverId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(75, 165, 77, 1),
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "<https://randomuser.me/api/portraits/men/5.jpg>"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.doctorName != null
                            ? "Dr. " + firstname
                            : 'Dr. Peter',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: DropdownButtonHideUnderline(
                    child:
                        DropdownButton<String>(
                      value: dropdownValue,
                      icon: SvgPicture.asset(
                          'assets/images/more_horiz_icon.svg',
                          semanticsLabel: 'vector'),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'Close Chat',
                        'Clear Chat',
                        'Change Doctor',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: MessagesWidget(
              idUser: widget.receiverId,
            )),
            NewMessageWidget(
                userId: userData.user.patientId,
                receiverId: widget.receiverId,
                doctorName: widget.doctorName),
          ],
        ),
      ),
    );
  }
}

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

  ChatDetailPage({@required this.receiverId, this.doctorName});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    print(widget.doctorName);
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
                            ? "Dr. " + widget.doctorName
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
                        /*DropdownButton<String>(
                //hint:
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                isExpanded: true,
                elevation: 16,
                //focusColor: _lightGold,
                style: TextStyle(color: HexColor("#172B4D")),
                /*underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                              ),*/
                onChanged: (newValue) {
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
              )*/
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

            /*ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.grey.shade200
                            : HexColor("#FFE5C4")),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),*/
            NewMessageWidget(
                userId: userData.user.patientId, receiverId: widget.receiverId),
            /*Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: NewMessageWidget(userId: userData.user.patientId),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

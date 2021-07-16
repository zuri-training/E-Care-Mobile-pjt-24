import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care_mobile/chat/api/utils.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_care_mobile/chat/chatDetailPage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConversationList extends StatefulWidget {
  final String receiverId;
  final String name;
  final String messageText;
  final String urlAvatar;
  final Timestamp time;
  final int messageCount;
  final bool isMessageRead;
  final String userId;

  ConversationList(
      {@required this.receiverId,
      @required this.name,
      @required this.messageText,
      @required this.urlAvatar,
      @required this.time,
      @required this.isMessageRead,
      @required this.messageCount,
      @required this.userId});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = Utils.toDateTime(widget.time);
    UserProvider userData = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(
              receiverId: widget.receiverId, doctorName: widget.name);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 12, 16, 12),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: HexColor("#F3EF82"),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/President_Barack_Obama.jpg/480px-President_Barack_Obama.jpg'),
                      //widget.urlAvatar),
                      maxRadius: 24,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.name != null
                                  ? 'Dr. ' + widget.name
                                  : 'sender',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Text(
                                  'You:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.20000000298023224),
                                      fontFamily: 'Inter',
                                      fontSize: widget.userId ==
                                              userData.user.patientId
                                          ? 14
                                          : 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1.1428571428571428),
                                ),
                                Expanded(
                                  child: Text(
                                    widget.messageText,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                        fontWeight: !widget.isMessageRead
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /*Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),*/
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.Hm().format(dateTime),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.699999988079071),
                        fontFamily: 'Inter',
                        fontSize: 14,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1.1428571428571428),
                  ),
                  SizedBox(
                    height: widget.messageCount == 0 ? 0 : 6,
                  ),
                  Container(
                      width: 16,
                      height: widget.messageCount == 0 ? 0 : 16,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(75, 165, 77, 1),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(16, 16)),
                      ),
                      child: Text(
                        widget.messageCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.1428571428571428),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:e_care_mobile/chat/api/chat_api.dart';
import 'package:e_care_mobile/providers/chat_provider.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class NewMessageWidget extends StatefulWidget {
  final String userId;
  final String receiverId;
  final String doctorName;

  const NewMessageWidget({
    @required this.userId,
    @required this.receiverId,
    @required this.doctorName,
    Key key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //ChatProvider receiverId; = Provider.of<ChatProvider>(context);
    UserProvider userData = Provider.of<UserProvider>(context);
    String fullname = userData.user.firstname + ' ' + userData.user.surname;

    void sendMessage() async {
      //var name = receiverId.
      FocusScope.of(context).unfocus();

      FirebaseApi.uploadMessage(widget.userId, _controller.text,
          widget.receiverId, fullname, widget.doctorName);
      _controller.clear();
    }

    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 60,
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    suffixIcon: Icon(
                      Icons.cloud_upload_outlined,
                      size: 30,
                    ),
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(235, 235, 235, 1),
                          style: BorderStyle.solid,
                          width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        borderSide: BorderSide(
                            color: HexColor("#BDBDBD"),
                            style: BorderStyle.solid,
                            width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        borderSide: BorderSide(
                            color: HexColor("#BDBDBD"),
                            style: BorderStyle.solid,
                            width: 1)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            FloatingActionButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  sendMessage();
                }
              },
              child: Center(
                child: SvgPicture.asset('assets/images/send_button.svg',
                    height: 24.0, width: 24.0, semanticsLabel: 'vector'),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}

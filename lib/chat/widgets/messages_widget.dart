import 'package:e_care_mobile/chat/api/chat_api.dart';
import 'package:e_care_mobile/chat/models/chatMessageModel.dart';
import 'package:e_care_mobile/providers/user_provider.dart';
import 'package:e_care_mobile/userData/user.dart';
import 'package:e_care_mobile/util/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'message_widget.dart';

class MessagesWidget extends StatelessWidget {
  final String idUser;

  const MessagesWidget({
    @required this.idUser,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User userData = Provider.of<UserProvider>(context).user;
    print('idUser $idUser');
    return StreamBuilder<List<ChatMessage>>(
      stream: FirebaseApi.getMessages(userData.patientId, idUser), //idUser),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: loadingSpinner(48.0, 2.0));
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              final messages = snapshot.data;
              //var as= (messages.length);
              //print('messages.length $as');
              return messages.isEmpty
                  ? buildText('Say Hi..')
                  : ListView.builder(
                      itemCount: messages.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        String formattedTime =
                            DateFormat.Hm().format(message.createdAt);
                        return MessageWidget(
                          message: message,
                          isMe: message.userId == userData.patientId,
                          time: formattedTime,
                        );
                      },
                    );
            }
        }
      },
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}

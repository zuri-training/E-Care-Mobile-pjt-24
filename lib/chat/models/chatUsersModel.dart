import 'package:e_care_mobile/chat/api/utils.dart';
import 'package:meta/meta.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class ChatUsers {
  final String idFrom;
  final String idTo;
  final String name;

  //final String firstname;
  final String urlAvatar;
  final DateTime lastMessageTime;
  final String messageText;
  final int messageCount;
  final bool isMessageRead;

  ChatUsers(
      {@required this.idFrom,
      @required this.idTo,
      @required this.name,
      @required this.urlAvatar,
      @required this.lastMessageTime,
      @required this.messageText,
      @required this.messageCount,
      @required this.isMessageRead});

  ChatUsers copyWith({
    String idFrom,
    String idTo,
    String name,
    String urlAvatar,
    String lastMessageTime,
    String messageText,
    int messageCount,
    bool isMessageRead,
  }) =>
      ChatUsers(
        idFrom: idFrom ?? this.idFrom,
        idTo: idTo ?? this.idTo,
        name: name ?? this.name,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
        messageText: messageText ?? this.messageText,
        messageCount: messageCount ?? this.messageCount,
        isMessageRead: isMessageRead ?? this.isMessageRead,
      );

  static ChatUsers fromJson(Map<String, dynamic> json) => ChatUsers(
        idFrom: json['idFrom'],
        idTo: json['idTo'],
        name: json['name'],
        urlAvatar: json['urlAvatar'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
        messageText: json['messageText'],
        messageCount: json['messageCount'],
        isMessageRead: json['isMessageRead'],
      );

  Map<String, dynamic> toJson() => {
        'idFrom': idFrom,
        'idTo': idTo,
        'name': name,
        'urlAvatar': urlAvatar,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
        'messageText': messageText,
        'messageCount': messageCount,
        'isMessageRead': isMessageRead,
      };
}

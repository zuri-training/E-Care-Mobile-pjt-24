import 'package:cloud_firestore/cloud_firestore.dart';

class Convo {
  Convo({this.id, this.userIds, this.lastMessage});

  factory Convo.fromFireStore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data();

    return Convo(
        id: doc.id,
        userIds: data['users'] ?? <dynamic>[],
        lastMessage: data['lastMessage'] ?? <dynamic>{});
  }

  String id;
  List<dynamic> userIds;
  Map<dynamic, dynamic> lastMessage;
}

class Message {
  Message(
      {this.id,
      this.messageText,
      this.idFrom,
      this.idTo,
      this.lastMessageTime,
      this.messageCount,
      this.name,
      this.urlAvatar,
      this.isMessageRead});

  factory Message.fromFireStore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data();

    return Message(
        id: doc.id,
        messageText: data['messageText'],
        idFrom: data['idFrom'],
        idTo: data['idTo'],
        messageCount: data['messageCount'],
        name: data['name'],
        urlAvatar: data['urlAvatar'],
        isMessageRead: data['isMessageRead']);
  }

  String id;
  String messageText;
  String idFrom;
  String idTo;
  DateTime lastMessageTime;
  int messageCount;
  String name;
  String urlAvatar;
  bool isMessageRead;
}

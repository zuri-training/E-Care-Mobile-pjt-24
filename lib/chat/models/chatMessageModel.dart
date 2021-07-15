import 'package:e_care_mobile/chat/api/utils.dart';
import 'package:flutter/cupertino.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class ChatMessage {
  String messageContent;
  String messageType;
  final String userId;
  final DateTime createdAt;
  final String urlAvatar;
  final String name;

  ChatMessage(
      {@required this.messageContent,
      @required this.messageType,
      @required this.userId,
      @required this.createdAt,
      @required this.urlAvatar,
      @required this.name});

  static ChatMessage fromJson(Map<String, dynamic> json) => ChatMessage(
        messageContent: json['messageContent'],
        messageType: json['messageType'],
        userId: json['userId'],
        createdAt: Utils.toDateTime(json['createdAt']),
        urlAvatar: json['urlAvatar'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'messageContent': messageContent,
        'messageType': messageType,
        'userId': userId,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
        'urlAvatar': urlAvatar,
        'name': name,
      };
}

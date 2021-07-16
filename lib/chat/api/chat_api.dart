import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care_mobile/chat/api/utils.dart';
import 'package:e_care_mobile/chat/models/chatMessageModel.dart';
import 'package:e_care_mobile/chat/models/chatUsersModel.dart';
import 'package:e_care_mobile/chat/models/convo.dart';
import 'package:e_care_mobile/models/doctors._model.dart';
import 'package:intl/intl.dart';

class FirebaseApi {
  static String getConversationID(String userId, String receiverId) {
    return userId.hashCode <= receiverId.hashCode
        ? userId + '_' + receiverId
        : receiverId + '_' + userId;
  }

  static Stream<List<Convo>> getUsers(userId) {
    return FirebaseFirestore.instance
        .collection('chats')
        //.orderBy(UserField.lastMessageTime, descending: true)
        .orderBy('lastMessage.lastMessageTime', descending: true)
        .where('users', arrayContains: userId)
        .snapshots()
        //.transform(Utils.transformer(ChatUsers.fromJson));
        .map((QuerySnapshot list) => list.docs
            .map((DocumentSnapshot doc) => Convo.fromFireStore(doc))
            .toList());
  }

  static Future<List<Doctors>> getSpecialist(specialization) async {
    QuerySnapshot asd =
        await FirebaseFirestore.instance.collection('doctors').get();
    var scs = asd.docs;
    return scs
        .map((DocumentSnapshot doc) => Doctors.fromFireStore(doc))
        .toList();
  }

  static Future uploadMessage(
      String userId, String message, receiverId, name, sender) async {
    var convoID = getConversationID(userId, receiverId);
    final refMessages =
        //FirebaseFirestore.instance.collection('chats/$receiverId/messages');
        //FirebaseFirestore.instance.collection('chats').doc(getConversationID(userId, receiverId));
        FirebaseFirestore.instance
            .collection('chats')
            .doc(getConversationID(userId, receiverId));

    /*final lastMessage = ChatUsers(
        idFrom: userId,
        idTo: receiverId,
        name: name,
        urlAvatar: 'urlAvatar',
        lastMessageTime: DateTime.now(),
        messageText: message,
        messageCount: 1,
        isMessageRead: false);*/

    refMessages.set(<String, dynamic>{
      'lastMessage': <String, dynamic>{
        'idFrom': userId,
        'idTo': receiverId,
        'name': name,
        'sender': sender,
        'urlAvatar': 'urlAvatar',
        'lastMessageTime': DateTime.now(),
        'messageText': message,
        'messageCount': 1,
        'isMessageRead': false
      },
      'users': <String>[userId, receiverId]
    }).then((dynamic success) {
      final DocumentReference messageDoc = FirebaseFirestore.instance
          .collection('chats')
          .doc(convoID)
          .collection(convoID)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        await transaction.set(
          messageDoc,
          <String, dynamic>{
            'messageContent': message,
            'messageType': 'sender',
            'userId': userId,
            'createdAt': DateTime.now(),
            'urlAvatar': 'myUrlAvatar',
            'name': name
          },
        );
      });
    });

    final refMes = refMessages.collection('messages');

    final newMessage = ChatMessage(
        messageContent: message,
        messageType: 'sender',
        userId: userId,
        createdAt: DateTime.now(),
        urlAvatar: 'myUrlAvatar',
        name: name);
    await refMes.add(newMessage.toJson());

    // Notify receiver
    final refUsers =
        FirebaseFirestore.instance.collection('chats/$receiverId/messages');
    await refUsers
        .doc(receiverId)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<ChatMessage>> getMessages(String userId, receiverId) {
    String _id = getConversationID(userId, receiverId);
    return FirebaseFirestore.instance
        .collection('chats/$_id/$_id')
        .orderBy(MessageField.createdAt, descending: false)
        .snapshots()
        .transform(Utils.transformer(ChatMessage.fromJson));
  }

  static void updateMessageRead(DocumentSnapshot doc, String convoID) {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(convoID)
        .collection(convoID)
        .doc(doc.id);

    //documentReference.set(<String, dynamic>{'read': true}, merge: true);
  }
}

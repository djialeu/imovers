import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newimovers/models/Annonce.dart';

import '../../models/Message.dart';

class MessageDatabaseService {

  List<Message> _messageListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return _messageFromSnapshot(doc);
    }).toList();
  }

  Message _messageFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("message not found");
    return Message.fromMap(data);
  }

  Stream<List<Message>> getMessage(String groupChatId, int limit) {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots().map(_messageListFromSnapshot);
  }

  Future<dynamic> getMyChaters(String username) async{
    print("dedans");

    // var data = await collectionReference.get();
    // List<String> myList = [];
    // print("On s'apprete");
    // data.docs.forEach((element) {myList.add(element.reference.id.toString());});
    // print(myList.first.toString());
    // return collectionReference.snapshots().toList();
  }

  void onSendMessage(String groupChatId, Message message) {
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference,message.toHashMap());
    });
  }
}
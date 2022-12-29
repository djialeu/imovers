import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newimovers/models/Annonce.dart';
import 'package:newimovers/models/ChatParams.dart';

class ChatListService {
  final ChatParams? _chatParams;

  final CollectionReference chatCollection =
  FirebaseFirestore.instance.collection("chats");

  ChatListService(this._chatParams);


  Future<void> saveChat(ChatParams params) async {
    return await chatCollection.doc(_chatParams!.getChatGroupId()).set(params.toHashMap());
  }

  ChatParams _chatFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("Chat not found");
    return ChatParams.fromMap(data);
  }

  Stream<ChatParams> get chat{
    return chatCollection.doc(_chatParams!.getChatGroupId()).snapshots().map(_chatFromSnapshot);
  }

  List<ChatParams> _chatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return _chatFromSnapshot(doc);
    }).toList();
  }

  Stream<List<ChatParams>> get chatters {
    return chatCollection.snapshots().map(_chatListFromSnapshot);
  }

}

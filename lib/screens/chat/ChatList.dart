

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newimovers/repositories/repo.dart';

import '../../animations/loading.dart';
import '../../models/Annonce.dart';
import '../../models/ChatParams.dart';
import '../../services/message/chatListService.dart';
import 'chatScreen.dart';

class ChatList extends StatefulWidget {
  final AppUser? connectedUser;

  const ChatList({Key? key, required this.connectedUser}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState(connectedUser);
}

class _ChatListState extends State<ChatList> {

  final AppUser? connectedUser;

  _ChatListState(this.connectedUser);


  List<String> chatters(List<ChatParams> params){
    List<String> chatters = [];
    params.forEach((element) {
      if(element.fromUser.username! != element.toUser){
        if(element.fromUser.username == connectedUser!.username){
          if(!chatters.contains(element.toUser)){
            chatters.add(element.toUser);
          }
        }
        if(element.toUser == connectedUser!.username){
          if(!chatters.contains(element.fromUser.username)){
            chatters.add(element.fromUser.username!);
          }
        }
      }
    });
    return chatters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Text('Your Chats')
      ),
      body: StreamBuilder<List<ChatParams>>(
        stream: ChatListService(null).chatters ,
        builder: (BuildContext context, AsyncSnapshot<List<ChatParams>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child:Loading());
          }
          if (snapshot.hasData) {
            print("Visible");
            var  mychatters = chatters(snapshot.data!);
            print(mychatters.length);
            // return ListView(
            //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //     String data = document.reference.id.toString() ;
            //     print(data);
            //     return ItemWidget(data , connectedUser!);
            //   }).toList(),
            // );
            // List<Message> listMessage = snapshot.data?? List.from([]);
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => ItemWidget(mychatters[index], connectedUser!),
              itemCount: mychatters.length,
            );
          } else {
            return Center(child:Loading());
          }
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  ItemWidget(this.chatUser, this.connectedUser) : super();
  final String chatUser;
  final AppUser connectedUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatScreen(chatParams: ChatParams( toUser: chatUser, fromUser: connectedUser))));
      },
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 8,
        child: Row(
          children: [
            Hero(
              tag: "profile" + chatUser,
              child:  Image.asset(
                "assets/images/user_default.png",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(chatUser,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Text("", style: TextStyle(color: Colors.grey[500], fontSize: 16))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
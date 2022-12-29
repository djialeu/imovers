import 'package:newimovers/models/Annonce.dart';

class ChatParams{
  final AppUser fromUser;
  final String toUser;

  ChatParams({required this.fromUser, required this.toUser});

  String getChatGroupId() {
    if (fromUser.username.hashCode <= toUser.hashCode) {
      return '${fromUser.username}-$toUser';
    } else {
      return '$toUser-${fromUser.username}';
    }
  }

  Map<String, dynamic> toHashMap() {
    return {
      'fromUser': fromUser.toJson(),
      'toUser': toUser,
    };
  }

  factory ChatParams.fromMap(Map<String, dynamic> data){
    return ChatParams(
        fromUser:  AppUser.fromJson( data['fromUser']) ,
        toUser: data['toUser'],
    );
  }
}
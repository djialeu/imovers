import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newimovers/models/Annonce.dart';

class Database {
    final username;

    final CollectionReference userCollection =
            FirebaseFirestore.instance.collection("users");

  Database(this.username);

    Future<void> saveUser(AppUser user) async {
        return await userCollection.doc(username).set(user.toJson());
    }

    AppUser _userFromSnapshot(DocumentSnapshot snapshot) {
        var data = snapshot.data();
        if (data == null) throw Exception("user not found");
        return AppUser.fromJson(data);
    }

    Stream<AppUser> get user {
        return userCollection.doc(username).snapshots().map(_userFromSnapshot);
    }

    List<AppUser> _userListFromSnapshot(QuerySnapshot snapshot) {
        return snapshot.docs.map((doc) {
        return _userFromSnapshot(doc);
      }).toList();
    }

    Stream<List<AppUser>> get users {
        return userCollection.snapshots().map(_userListFromSnapshot);
    }

}

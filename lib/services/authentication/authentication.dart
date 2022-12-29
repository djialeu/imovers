import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../models/Annonce.dart';

class AuthenticationService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user){
    return user != null ? AppUser(username: user.email ) : null;
  }

  Stream<AppUser?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email , String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    }catch(exception){
      log(exception.toString());
      return null;
    }
  }

  Future<AppUser?> registerInWithEmailAndPassword(String email , String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    }catch(exception){
      log(exception.toString());
      return null;
    }
  }

  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(exception){
      log(exception.toString());
      return null;
    }
  }
}
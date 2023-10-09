import 'dart:async';
import 'package:flutix/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static get genre => null;

  static Future<void> updateUser(UserModel user) async {
    _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguages': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return UserModel(id, snapshot['email'], snapshot['name'], snapshot['balance'],
        snapshot['selectedGenres'], snapshot['selectedLanguages']);
  }
}
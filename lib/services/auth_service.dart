import 'dart:async';
import 'dart:convert';
import 'package:flutix/models/user.dart';
import 'package:flutix/extensions/firebase_user_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutix/services/user_service.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthService {
  // ignore: prefer_final_fields
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static get user => null;

  static Future<void> signUp(UserModel data) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: data.email, password: data.password!);
      UserModel user = result.user!.convertToUser(
          name: data.name,
          selectedGenres: data.selectedGenres,
          selectedLanguage: data.selectedLanguage);
      String _authData = json.encode(user.toMap());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth', _authData);
      await UserService.updateUser(user);
    } catch (e) {}
  }

  static Future<void> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      UserModel user = await UserService.getUser(result.user!.uid);
      String _authData = json.encode(user.toMap());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth', _authData);
    } catch (e) {
      print(e);
    }
  }
}

class SignInSignUpResult {
  final UserModel user;
  final String message;

  SignInSignUpResult({required this.user, required this.message});
}

import 'dart:async';
import 'package:flutix/models/user.dart';
import 'package:flutix/extensions/firebase_user_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutix/services/user_service.dart';

class AuthService {
  // ignore: prefer_final_fields
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static get user => null;

  static Future<void> signUp(String email, String password, String name,
      List<String> selectedGenres, String selectedLanguage) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel user = result.user!.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      await UserService.updateUser(user);
    } catch (e) {
    }
  }

  static Future<void> signIn(String email, String password) async {
    try {
      UserCredential result = (await _auth.signInWithEmailAndPassword(
          email: email, password: password));
    } catch (e) {}
  }
}

class SignInSignUpResult {
  final UserModel user;
  final String message;

  SignInSignUpResult({required this.user, required this.message});
}

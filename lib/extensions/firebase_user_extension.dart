import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutix/models/user.dart';
import 'package:flutix/services/user_service.dart';

extension FirebaseUserExtension on User {
  UserModel convertToUser(
          {String name = "No Name",
          String email = "No Email",
          List<String> selectedGenres = const [],
          String selectedLanguage = "English",
          int balance = 50000}) =>
      UserModel(uid, email, name, selectedGenres, selectedLanguage, balance);

  Future<UserModel> fromFireStore() async =>
      await UserService.getUser(this.uid);
}

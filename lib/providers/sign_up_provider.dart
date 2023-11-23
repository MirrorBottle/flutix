import 'package:flutix/models/user.dart';
import 'package:flutter/material.dart';
class SignUpProvider extends ChangeNotifier {
  final UserModel _user = UserModel(
    balance: 0,
    email: '',
    id: '',
    name: '',
    selectedGenres: [],
    selectedLanguage: '',
    profilePicture: '',
    password: ''
  );
  UserModel get user {
    return _user;
  }

  changeInfoData({required String name, required String email, required String password}) {
    _user.name = name;
    _user.email = email;
    _user.password = password;
  }

  changeLanguage(String language) {
    _user.selectedLanguage = language;
  }

  changeGenres(List<String> selectedGenres) {
    _user.selectedGenres = selectedGenres;
  }
}
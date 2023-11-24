import 'dart:io';
import 'package:intl/intl.dart';
class UserModel {
  final String id;
  String email;
  String name;
  List<String> selectedGenres;
  File? profilePictureFile;
  String? profilePicture;
  String selectedLanguage;
  int balance;
  String? password;
  String? balanceFormat;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.selectedGenres,
    required this.selectedLanguage,
    required this.balance,
    this.profilePicture,
    this.profilePictureFile,
    this.password,
    this.balanceFormat
  });

  factory UserModel.fromJson(Map<String, dynamic> _json) {
    return UserModel(
      id: _json['id'],
      email: _json['email'],
      name: _json['name'],
      selectedGenres: List<String>.from(_json['selectedGenres']),
      selectedLanguage: _json['selectedLanguage'],
      profilePicture: _json['profilePicture'],
      balance: _json['balance'],
      balanceFormat: NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ').format(_json['balance']).replaceAll(RegExp(r'\,00$'), ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'selectedGenres': selectedGenres,
      'selectedLanguage': selectedLanguage,
      'profilePicture': profilePicture,
      'balance': balance,
    };
  }
}

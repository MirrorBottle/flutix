import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  //final String profilePicture;
  final List<String> selectedGenres;
  final String selectedLanguage;
  final int balance;

  // ignore: prefer_const_constructors_in_immutables
  UserModel(this.id, this.email, this.name, this.selectedGenres,
      this.selectedLanguage, this.balance);

  @override
  String toString() {
    return "[$id] - $name, $email";
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        balance,
        //profilePicture,
        selectedGenres,
        selectedLanguage
      ];

  get profilePicture => null;
}

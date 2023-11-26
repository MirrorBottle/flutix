import 'package:flutix/models/user.dart';

class Ticket {
  String? id;
  String date;
  String time;
  String cinema;
  int price;
  int total;
  String seats;
  UserModel? user;
  int movieId;
  String movieLanguage;
  String movieTitle;
  double movieVote;
  String moviePoster;
  String movieBackdrop;


  Ticket({
    this.id,
    required this.date,
    required this.time,
    required this.cinema,
    required this.price,
    required this.total,
    required this.seats,
    required this.moviePoster,
    required this.movieId,
    required this.movieLanguage,
    required this.movieTitle,
    required this.movieVote,
    required this.movieBackdrop,
    this.user,
  });
}
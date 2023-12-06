import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Ticket.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Ticket(
      id: doc.id,
      date: data['date'],
      time: data['time'],
      cinema: data['cinema'],
      price: data['price'],
      total: data['total'],
      seats: data['seats'],
      moviePoster: data['movie_poster'],
      movieId: data['movie_id'],
      movieLanguage: data['movie_language'],
      movieTitle: data['movie_title'],
      movieVote: data['movie_vote'],
      movieBackdrop: data['movie_backdrop'],
    );
  }
}
import 'package:flutix/models/ticket.dart';
import 'package:flutix/models/user.dart';
import 'package:flutter/material.dart';

class TicketProvider extends ChangeNotifier {
  final Ticket _ticket = Ticket(
    date: '',
    time: '',
    cinema: '',
    price: 25000,
    total: 0,
    seats: '',
    moviePoster: '',
    movieId: 0,
    movieLanguage: '',
    movieTitle: '',
    movieVote: 0,
    movieBackdrop: '',
  );
  Ticket get ticket {
    return _ticket;
  }

  changeMovieData({
    required String moviePoster,
    required int movieId,
    required String movieLanguage,
    required String movieTitle,
    required double movieVote,
    required String movieBackdrop,
  }) {
    _ticket.moviePoster = moviePoster;
    _ticket.movieId = movieId;
    _ticket.movieLanguage = movieLanguage;
    _ticket.movieTitle = movieTitle;
    _ticket.movieVote = movieVote;
    _ticket.movieBackdrop = movieBackdrop;
  }

  changeDateData({
    required String date
  }) {
    _ticket.date = date;
  }

  changeCinemaData({
    required String cinema,
    required String time
  }) {
    _ticket.cinema = cinema;
    _ticket.time = time;
  }

  changeSeatsData({
    required List<String> seats
  }) {
    _ticket.seats = seats.join(", ");
    _ticket.total = (seats.length * _ticket.price) + 10000;
  }
}

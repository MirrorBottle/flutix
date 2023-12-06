import 'dart:convert';

import 'package:flutix/components/button_component.dart';
import 'package:flutix/models/ticket.dart';
import 'package:flutix/models/user.dart';
import 'package:flutix/pages/auth/sign_up_screen.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

List<Widget> buildStarRating(double rating) {
  // Ensure the rating is within the valid range (0 to 5)
  rating = rating / 2;

  // Determine the number of full stars, half stars, and gray stars
  int fullStars = rating.floor();
  int halfStars = ((rating - fullStars)).round();
  int grayStars = 5 - fullStars - halfStars;

  // Create a list of star icons
  List<Widget> starIcons = [];

  // Add full stars
  starIcons.addAll(List.generate(
      fullStars, (index) => const Icon(Icons.star, color: constTernaryColor)));

  // Add half star if needed
  starIcons.addAll(List.generate(
      halfStars, (index) => const Icon(Icons.star_half, color: constTernaryColor)));

  // Add gray stars only if there are positive grayStars
  starIcons.addAll(List.generate(grayStars > 0 ? grayStars : 0,
      (index) => const Icon(Icons.star, color: Colors.grey)));

  // Return a row of star icons
  return starIcons;
}
class TicketDetailScreen extends StatefulWidget {
  Ticket ticket;
  TicketDetailScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  _TicketDetailScreenState createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  
  UserModel? _auth;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedAuth = prefs.getString('auth') ?? "{}";
    setState(() {
      _auth = UserModel.fromJson(json.decode(encodedAuth));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: constPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 18),
          child: BackButton(),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // * BACKDROP
          Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.ticket.movieBackdrop),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              top: 0),

          // * BACKDROP OVERLAY

          Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[constPrimaryColor, Colors.transparent]),
                ),
              ),
              top: 0),
          // * POSTER
          Positioned(
              top: 100,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      clipBehavior: Clip.antiAlias,
                      color: constPrimaryColor,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.ticket.moviePoster),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 130,
                        height: 195,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                                  width: 200,
                                  child: Text(widget.ticket.movieTitle,
                                      style: constHeadingStyle.copyWith(
                                          color: Colors.white, fontSize: 28)),
                                ),
                          const SizedBox(height: 10),
                          Text(widget.ticket.movieLanguage,
                              style: constSecondaryTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text(widget.ticket.movieVote.toString(),
                                  style: constNumberTextStyle.copyWith(
                                      color: constTernaryColor, fontSize: 20)),
                              const SizedBox(
                                width: 10,
                              ),
                              ...buildStarRating(widget.ticket.movieVote)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),

          // * MAIN CONTENT
          Positioned(
              top: 320,
              bottom: 60,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20.0),
                height: 1000,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: constPrimaryColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ticket Details",
                          style: constHeadingStyle.copyWith(
                              color: Colors.white, fontSize: 22)),
                      const SizedBox(height: 15),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Text(
                          "Cinema",
                          style: constTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(widget.ticket.cinema,
                            style: constSecondaryTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Text(
                          "Date & Time",
                          style: constTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text("${widget.ticket.date}, ${widget.ticket.time}",
                            style: constSecondaryTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Text(
                          "Price /pcs",
                          style: constTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ').format(widget.ticket.price).replaceAll(RegExp(r'\,00$'), ''),
                            style: constNumberTextStyle.copyWith(
                                color: constTernaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Text(
                          "Seat",
                          style: constTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(widget.ticket.seats,
                            style: constSecondaryTextStyle.copyWith(
                                color: constTernaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama",
                                style: constTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _auth != null ? _auth!.name : '',
                                style: constSecondaryTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                "Total",
                                style: constTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ').format(widget.ticket.total).replaceAll(RegExp(r'\,00$'), ''),
                                style: constNumberTextStyle.copyWith(
                                  color: constTernaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/QR1.png',
                                width: 105,
                              ),
                              SizedBox(height: 5),
                              Text("ID A20230121",
                                  style: constSecondaryTextStyle.copyWith(
                                    color: kBgColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: constSecondaryColor,
                ),
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text("Dwonload Invoice",
                    style: constTextStyle.copyWith(
                        color: constTernaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
              ))
        ],
      ),
    );
  }
}

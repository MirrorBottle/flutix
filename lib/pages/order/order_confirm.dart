import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/components/button_component.dart';
import 'package:flutix/models/ticket.dart';
import 'package:flutix/models/user.dart';
import 'package:flutix/pages/auth/sign_up_screen.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutix/pages/order/order_success.dart';
import 'package:flutix/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CastCard extends StatelessWidget {
  final Map<String, String> data;
  const CastCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              clipBehavior: Clip.antiAlias,
              color: constPrimaryColor,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 100,
                  height: 130,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 100,
              child: Text(data["name"]!,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: constSecondaryTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 100,
              child: Text(data["character"]!,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: constSecondaryTextStyle.copyWith(
                      color: Colors.white, fontSize: 14)),
            )
          ]),
        ));
  }
}

class OrderConfirmScreen extends StatefulWidget {
  const OrderConfirmScreen({Key? key}) : super(key: key);

  @override
  _OrderConfirmScreenState createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  static final db = FirebaseFirestore.instance;
  bool _loading = false;
  UserModel? _auth;

  void _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedAuth = prefs.getString('auth') ?? "{}";
    setState(() {
      _auth = UserModel.fromJson(json.decode(encodedAuth));
    });
  }

  void _handleCheckout() async {
    Ticket ticket = Provider.of<TicketProvider>(context, listen: false).ticket;
    setState(() {
      _loading = true;
    });
    DocumentReference userRef = db.collection('users').doc(_auth!.id);
    await db.collection("tickets").add({
      "price": ticket.price,
      "cinema": ticket.cinema,
      "seats": ticket.seats,
      "time": ticket.time,
      "date": ticket.date,
      "total": ticket.total,
      "movie_vote": ticket.movieVote,
      "movie_title": ticket.movieTitle,
      "movie_id": ticket.movieId,
      "movie_language": ticket.movieLanguage,
      "movie_poster": ticket.moviePoster,
      "movie_backdrop": ticket.movieBackdrop,
      "user": userRef
    }).then((value) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrderSuccess()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketProvider>(builder: (context, ticketData, child) {
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
                      image: NetworkImage(ticketData.ticket.movieBackdrop),
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
                              image:
                                  NetworkImage(ticketData.ticket.moviePoster),
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
                              child: Text(ticketData.ticket.movieTitle,
                                style: constHeadingStyle.copyWith(
                                    color: Colors.white, fontSize: 28)),
                            ),
                            const SizedBox(height: 10),
                            Text(ticketData.ticket.cinema,
                                style: constSecondaryTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text(
                                "${ticketData.ticket.date} ${ticketData.ticket.time}",
                                style: constSecondaryTextStyle.copyWith(
                                    color: Colors.white, fontSize: 15)),
                            const SizedBox(height: 15),
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
                        Text("Order Detail",
                            style: constHeadingStyle.copyWith(
                                color: Colors.white, fontSize: 22)),
                        const SizedBox(height: 15),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "Seats",
                            style: constTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(ticketData.ticket.seats,
                              style: constLabelNumberTextStyle.copyWith(
                                  color: constTernaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "Ticket Price",
                            style: constTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                              NumberFormat.currency(
                                      locale: 'id_ID', symbol: 'Rp')
                                  .format(ticketData.ticket.price),
                              style: constNumberTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "Fees",
                            style: constTextStyle.copyWith(
                                color: constTernaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text("Rp. 10.000",
                              style: constNumberTextStyle.copyWith(
                                  color: constTernaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "Total",
                            style: constTextStyle.copyWith(
                                color: constTernaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                              NumberFormat.currency(
                                      locale: 'id_ID', symbol: 'Rp')
                                  .format(ticketData.ticket.total),
                              style: constNumberTextStyle.copyWith(
                                  color: constTernaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ButtonIconComponent(
                loading: _loading,
                buttontext: "Checkout Now",
                invert: true,
                onPressed: _handleCheckout,
              ),
            )
          ],
        ),
      );
    });
  }
}

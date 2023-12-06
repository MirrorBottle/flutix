import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/components/button_component.dart';
import 'package:flutix/components/image_component.dart';
import 'package:flutix/models/ticket.dart';
import 'package:flutix/models/user.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class TicketLisTile extends StatelessWidget {
  Ticket ticket;
  TicketLisTile({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageComponent(url: ticket.moviePoster, height: 110, width: 80),
                const SizedBox(width: 10),
                SizedBox(
                  height: 110,
                  width: 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ticket.movieTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: constSecondaryTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      Text(
                        ticket.date,
                        style: constSecondaryTextStyle.copyWith(
                            color: Colors.white),
                      ),
                      Text(ticket.cinema,
                          style: constSecondaryTextStyle.copyWith(
                              color: Colors.white, fontSize: 16)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        ticket.seats,
                        style: constNumberTextStyle.copyWith(
                            color: constTernaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
            const Icon(Icons.chevron_right, size: 36, color: constTernaryColor)
          ],
        ),
      ),
    );
  }
}

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({Key? key}) : super(key: key);

  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final _scrollController = ScrollController();
  final db = FirebaseFirestore.instance;
  UserModel? _auth;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('tickets').snapshots(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              controller: _scrollController,
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Tickets,",
                            style: constTextStyle.copyWith(
                                color: constPrimaryColor, fontSize: 34)),
                        Text("Old and New",
                            style: constHeadingStyle.copyWith(
                                color: constPrimaryColor,
                                fontSize: 34,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 250),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      color: constPrimaryColor,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: constSecondaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TabBar(
                                controller: _tabController,
                                unselectedLabelColor: Colors.white,
                                labelColor: constPrimaryColor,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                tabs: [
                                  Tab(
                                    child: Text("Now",
                                        style: GoogleFonts.robotoSlab(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Tab(
                                    child: Text("History",
                                        style: GoogleFonts.robotoSlab(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          if (snapshot.hasData) ...[
                            ...snapshot.data!.docs.map((doc) {
                                  Ticket ticket =
                                      Ticket.fromFirestore(doc);
                                  return TicketLisTile(ticket: ticket);
                                }).toList(),
                          ] else ...[
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                          ]
                        ]),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

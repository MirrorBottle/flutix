import 'package:flutix/components/button_component.dart';
import 'package:flutix/components/image_component.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class TicketLisTile extends StatelessWidget {
  Map<String, dynamic> ticket;
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
                ImageComponent(url: ticket['image'], height: 110, width: 80),
                const SizedBox(width: 10),
                SizedBox(
                  height: 110,
                  width: 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ticket['title'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: constSecondaryTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      Text(
                        ticket['date'],
                        style: constSecondaryTextStyle.copyWith(
                            color: Colors.white),
                      ),
                      Text(ticket['theater'],
                          style: constSecondaryTextStyle.copyWith(
                              color: Colors.white, fontSize: 16)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${ticket['studio']} - ${ticket['seat']}",
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> _tickets = [
      {
        "title": "Begin Again",
        "date": "Sat 12, 12.00",
        "theater": "Osaka High Hills",
        "studio": "STUDIO 1",
        "seat": "C1, C2",
        "image":
            "https://www.themoviedb.org/t/p/w220_and_h330_face/xGw7jPsYFusRbWh29Bxd6IeAiwZ.jpg"
      },
      {
        "title": "Godzilla Minus One",
        "date": "Sat 12, 12.00",
        "theater": "Osaka High Hills",
        "studio": "STUDIO 1",
        "seat": "C1, C2",
        "image":
            "https://www.themoviedb.org/t/p/w220_and_h330_face/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg"
      },
      {
        "title": "Begin Again",
        "date": "Sat 12, 12.00",
        "theater": "Osaka High Hills",
        "studio": "STUDIO 1",
        "seat": "C1, C2",
        "image":
            "https://www.themoviedb.org/t/p/w220_and_h330_face/xGw7jPsYFusRbWh29Bxd6IeAiwZ.jpg"
      },
      {
        "title": "Begin Again",
        "date": "Sat 12, 12.00",
        "theater": "Osaka High Hills",
        "studio": "STUDIO 1",
        "seat": "C1, C2",
        "image":
            "https://www.themoviedb.org/t/p/w220_and_h330_face/xGw7jPsYFusRbWh29Bxd6IeAiwZ.jpg"
      },
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  minHeight: MediaQuery.of(context).size.height - 310),
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
                    ..._tickets.map((ticket) => TicketLisTile(ticket: ticket))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutix/components/button_component.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutix/pages/order/order_seat.dart';
import 'package:flutix/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class OrderDateCinemaModel {
  String name;
  List<String> times;

  OrderDateCinemaModel({required this.name, required this.times});
}

class OrderDateScreen extends StatefulWidget {
  const OrderDateScreen({Key? key}) : super(key: key);

  @override
  _OrderDateScreenState createState() => _OrderDateScreenState();
}

class _OrderDateScreenState extends State<OrderDateScreen>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();

  final List<OrderDateCinemaModel> _cinemas = [
    OrderDateCinemaModel(
        name: "Tokyo Bunkamura",
        times: ["12.00", "13.00", "14.50", "15.00", "16.00"]),
    OrderDateCinemaModel(
        name: "Prince Shinagawa", times: ["14.50", "17.40", "21.00", "23.40"]),
    OrderDateCinemaModel(
        name: "Shinjuku Wald 9",
        times: ["09.00", "12.00", "16.00", "17.50", "19.20"]),
  ];

  String _cinema = "";
  String _time = "";

  @override
  void initState() {
    super.initState();
    Provider.of<TicketProvider>(context, listen: false).changeDateData(
        date: DateFormat('dd/MM/yy').format(DateTime(2023, 11, 26)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketProvider>(builder: (context, ticketData, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 18),
            child: BackButton(
              color: constPrimaryColor,
              onPressed: () {},
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("When,",
                        style: constTextStyle.copyWith(
                            color: constPrimaryColor, fontSize: 34)),
                    Text("Where?",
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
                    minHeight: MediaQuery.of(context).size.height - 230),
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
                      Text("Pick a Day",
                          style:
                              constHeadingStyle.copyWith(color: Colors.white)),
                      const SizedBox(height: 20),
                      CalendarTimeline(
                        initialDate: DateTime(2023, 11, 26),
                        firstDate: DateTime(2023, 1, 15),
                        lastDate: DateTime(2023, 12, 20),
                        onDateSelected: (date) => {
                          Provider.of<TicketProvider>(context, listen: false)
                              .changeDateData(
                                  date: DateFormat('dd/MM/yy').format(date))
                        },
                        leftMargin: 20,
                        monthColor: Colors.grey,
                        dayColor: constTernaryColor,
                        activeDayColor: constPrimaryColor,
                        activeBackgroundDayColor: Colors.white,
                        dotsColor: constPrimaryColor,
                        locale: 'en_ISO',
                      ),
                      const SizedBox(height: 30),
                      Text("Get a Place",
                          style:
                              constHeadingStyle.copyWith(color: Colors.white)),
                      const SizedBox(height: 20),
                      ..._cinemas.map((cinema) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cinema.name,
                                  style: constSecondaryTextStyle.copyWith(
                                      color: Colors.white, fontSize: 20)),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 45,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: cinema.times
                                      .map((time) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _cinema = cinema.name;
                                                _time = time;
                                              });
                                              Provider.of<TicketProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeCinemaData(
                                                      cinema: cinema.name,
                                                      time: time);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              padding: const EdgeInsets.only(
                                                  right: 20,
                                                  left: 20,
                                                  top: 10,
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                color: _cinema == cinema.name &&
                                                        _time == time
                                                    ? Colors.white
                                                    : constSecondaryColor,
                                              ),
                                              child: Text(time,
                                                  style: constNumberTextStyle
                                                      .copyWith(
                                                          color: _cinema ==
                                                                      cinema
                                                                          .name &&
                                                                  _time == time
                                                              ? constPrimaryColor
                                                              : Colors.white,
                                                          fontSize: 16)),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          )),
                      const SizedBox(height: 30),
                      ButtonIconComponent(
                        buttontext: "Next, Your Seat!",
                        invert: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderSeatScreen()),
                          );
                        },
                      ),
                    ]),
              ),
            ],
          ),
        ),
      );
    });
  }
}

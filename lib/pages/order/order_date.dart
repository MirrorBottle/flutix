import 'package:flutix/components/button_component.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'dart:math';


class OrderDateScreen extends StatefulWidget {
  const OrderDateScreen({Key? key}) : super(key: key);

  @override
  _OrderDateScreenState createState() => _OrderDateScreenState();
}

class _OrderDateScreenState extends State<OrderDateScreen>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        style: constHeadingStyle.copyWith(color: Colors.white)),
                    const SizedBox(height: 20),
                    CalendarTimeline(
                      initialDate: DateTime(2020, 4, 20),
                      firstDate: DateTime(2019, 1, 15),
                      lastDate: DateTime(2020, 11, 20),
                      onDateSelected: (date) => print(date),
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
                        style: constHeadingStyle.copyWith(color: Colors.white)),
                    const SizedBox(height: 20),
                    Text("CGV Osaka Harukas",
                        style: constSecondaryTextStyle.copyWith(
                            color: Colors.white, fontSize: 20)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 45,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: ["12.00", "13.00", "14.50", "15.00", "16.00", "18.00", "21.00"]
                            .map((data) => Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(5)),
                                        color: data == "14.50" ? Colors.white : constSecondaryColor,
                                  ),
                                  child: Text(data,
                                      style: constNumberTextStyle.copyWith(
                                          color: data == "14.50" ? constPrimaryColor : Colors.white, fontSize: 16)),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text("CGV Beverly Hills",
                        style: constSecondaryTextStyle.copyWith(
                            color: Colors.white, fontSize: 20)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 45,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: ["12.00", "13.00", "14.50", "15.00", "16.00", "18.00", "21.00"]
                            .map((data) => Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(5)),
                                        color: data == "13.00" ? Colors.white : constSecondaryColor,
                                  ),
                                  child: Text(data,
                                      style: constNumberTextStyle.copyWith(
                                          color: data == "13.00" ? constPrimaryColor : Colors.white, fontSize: 16)),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ButtonIconComponent(
                      buttontext: "Next, Your Seat!",
                      invert: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                        );
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

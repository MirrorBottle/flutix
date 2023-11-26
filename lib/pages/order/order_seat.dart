import 'package:flutix/components/button_component.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutix/pages/order/order_confirm.dart';
import 'package:flutix/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class SeatComponent extends StatelessWidget {
  final String seat;
  bool isSelected;
  bool isSold;
  var onPressed;
  SeatComponent(
      {Key? key,
      required this.seat,
      required this.onPressed,
      required this.isSelected,
      required this.isSold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return seat == "-"
        ? const SizedBox(
            height: 28,
            width: 28,
          )
        : GestureDetector(
            onTap: isSold ? () {} : onPressed,
            child: Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: isSold
                      ? Color(0xFFEB9481)
                      : (isSelected ? Color(0xFF82FE96) : Color(0xFFD9D9D9))),
              child: Text(
                seat,
                style: constLabelNumberTextStyle.copyWith(
                    color: Colors.black, fontSize: 16),
              ),
            ),
          );
  }
}

class OrderSeatScreen extends StatefulWidget {
  const OrderSeatScreen({Key? key}) : super(key: key);

  @override
  _OrderSeatScreenState createState() => _OrderSeatScreenState();
}

class _OrderSeatScreenState extends State<OrderSeatScreen>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _seatColumns = ["A", "B", "C", "D", "E", "F"];
  final _seatRows = 7;

  List<String> _seats = [];
  List<String> _selectedSeats = [];
  List<String> _soldSeats = ["A4", "B1", "B2", "C1", "C3", "C6"];
  @override
  void initState() {
    super.initState();
    List<String> seats = [];
    for (var seatColumn = 0; seatColumn < _seatColumns.length; seatColumn++) {
      for (var seatRow = 1; seatRow <= _seatRows; seatRow++) {
        String column = _seatColumns[seatColumn];
        String row =
            seatRow > 4 ? (seatRow - 1).toString() : seatRow.toString();
        seats.add(seatRow == 4 ? "-" : "$column$row");
      }
    }
    setState(() {
      _seats = seats;
    });
  }

  void _handleSeatSelected(seat) {
    setState(() {
      _selectedSeats.contains(seat)
          ? _selectedSeats.remove(seat)
          : _selectedSeats.add(seat);
    });
    Provider.of<TicketProvider>(context, listen: false)
        .changeSeatsData(seats: _selectedSeats);
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
                  Text("Choose Your",
                      style: constTextStyle.copyWith(
                          color: constPrimaryColor, fontSize: 34)),
                  Text("Throne, Lord!",
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: constTernaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Text("Layar Bioskop",
                          style: constHeadingStyle.copyWith(fontSize: 18)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 350,
                      child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: _seatRows,
                        children: [
                          ..._seats
                              .map((seat) => SeatComponent(
                                    seat: seat,
                                    isSelected: _selectedSeats.contains(seat),
                                    isSold: _soldSeats.contains(seat),
                                    onPressed: () {
                                      _handleSeatSelected(seat);
                                    },
                                  ))
                              .toList()
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SeatComponent(
                                  seat: "",
                                  isSelected: false,
                                  isSold: false,
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Available",
                                  style: constSecondaryTextStyle.copyWith(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SeatComponent(
                                  seat: "",
                                  isSelected: false,
                                  isSold: true,
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Sold",
                                  style: constSecondaryTextStyle.copyWith(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Your Seat(s)",
                              style: constSecondaryTextStyle.copyWith(
                                  color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              width: 120, //from here
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  ..._selectedSeats.map((seat) => Container(
                                        margin: EdgeInsets.all(5),
                                        child: SeatComponent(
                                          seat: seat,
                                          isSelected: true,
                                          isSold: false,
                                          onPressed: () {},
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    ButtonIconComponent(
                      buttontext: "Checkout Now!",
                      invert: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderConfirmScreen()),
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

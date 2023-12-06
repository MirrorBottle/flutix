import 'package:flutix/components/button_component.dart';
import 'package:flutix/components/image_component.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'dart:math';


class TransactionListTile extends StatelessWidget {
  Map<String, dynamic> transaction;
  TransactionListTile({Key? key, required this.transaction}) : super(key: key);



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
                ImageComponent(url: transaction['image'], height: 110, width: 80),
                const SizedBox(width: 10),
                SizedBox(
                  height: 110,
                  width: 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transaction['title'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: constSecondaryTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      Text(
                        transaction['date'],
                        style: constSecondaryTextStyle.copyWith(
                            color: Colors.white),
                      ),
                      Text(transaction['theater'],
                          style: constSecondaryTextStyle.copyWith(
                              color: Colors.white, fontSize: 16)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        transaction['price'],
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

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);



  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  var _selectedIndex = 1;
  @override
  void initState() {
    super.initState();
  }

void _handleBackButton() {
    if (_selectedIndex > 1) {
      setState(() {
        _selectedIndex = _selectedIndex - 1;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> _transactions = [
      {
        "title": "Begin Again",
        "date": "Sat 12, 12.00",
        "theater": "Osaka High Hills",
        "price": "IDR 50.000",
        "image":
            "https://www.themoviedb.org/t/p/w220_and_h330_face/xGw7jPsYFusRbWh29Bxd6IeAiwZ.jpg"
      },
      {
        "title": "Godzilla Minus One",
        "date": "Sat 12, 12.00",
        "theater": "Osaka High Hills",
        "price": "IDR 50.000",
        "image":
            "https://www.themoviedb.org/t/p/w220_and_h330_face/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg"
      },
    ];
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
            onPressed: () {_handleBackButton();},
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
                  Text("Your Movies",
                      style: constTextStyle.copyWith(
                          color: constPrimaryColor, fontSize: 34)),
                  Text("Bucks!",
                      style: constHeadingStyle.copyWith(
                          color: constPrimaryColor,
                          fontSize: 34,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: constSecondaryColor,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: <Color>[
                          constPrimaryColor,
                          constSecondaryColor
                        ])),
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: const Image(
                        image: AssetImage('assets/images/logo_full_trans.png'),
                        height: 36,
                      ),
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("IDR 180.000", style: constNumberTextStyle.copyWith(color: constTernaryColor, fontWeight: FontWeight.bold, fontSize: 32),),
                      Text("Bayu Setiawan",
                          style: constSecondaryTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
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
                    Text("Recent Transactions",
                        style: constHeadingStyle.copyWith(color: Colors.white)),
                    const SizedBox(height: 20),
                    ..._transactions.map((transaction) => TransactionListTile(transaction: transaction))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

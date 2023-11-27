import 'package:flutix/components/button_component.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class ProfileRatingScreen extends StatefulWidget {
  const ProfileRatingScreen({Key? key}) : super(key: key);

  @override
  _ProfileRatingScreenState createState() => _ProfileRatingScreenState();
}

class _ProfileRatingScreenState extends State<ProfileRatingScreen>
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Give us,",
                    style: constTextStyle.copyWith(
                      color: constPrimaryColor,
                      fontSize: 34,)),
                Text("a Rating !!!",
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
            child: ButtonComponent(
              buttontext: 'Rate Us',
              onPressed: () {},
              invert: true,
            ),
          ),
        ]),
      ),
    );
  }
}

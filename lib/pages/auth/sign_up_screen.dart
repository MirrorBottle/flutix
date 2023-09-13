import 'package:flutix/components/button_component.dart';
import 'package:flutix/pages/auth/log_in_screen.dart';
import 'package:flutix/pages/auth/sign_up/sign_up_genre_screen.dart';
import 'package:flutix/pages/auth/sign_up/sign_up_info_screen.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();

  var _selectedIndex = 1;
  final _headlines = [
    ["Light On,", "Sign Up!"],
    ["Pick Your", "Poisons..."],
    ["All Set,", "Ready to Go?"]
  ];

  @override
  void initState() {
    super.initState();
  }

  void _handleContinueButton() {
    if (_selectedIndex < 3) {
      setState(() {
        _selectedIndex = _selectedIndex + 1;
      });
    }
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  void _handleBackButton() {
    if (_selectedIndex > 1) {
      setState(() {
        _selectedIndex = _selectedIndex - 1;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: constPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: constPrimaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 18),
          child: BackButton(
            onPressed: () {
              _handleBackButton();
            },
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
                  Text(_headlines[_selectedIndex - 1][0],
                      style: constTextStyle.copyWith(
                          color: Colors.white, fontSize: 34)),
                  Text(_headlines[_selectedIndex - 1][1],
                      style: constHeadingStyle.copyWith(
                          color: Colors.white,
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
                color: Color.fromARGB(255, 250, 250, 250),
              ),
              child: Column(children: [
                if (_selectedIndex == 1) ...[
                  SignUpInfoScreen(voidCallback: _handleContinueButton),
                ] else if (_selectedIndex == 2) ...[
                  SignUpGenreScreen(voidCallback: _handleContinueButton),
                ] else ...[
                  SvgPicture.asset(
                    'assets/svg/account_create_success.svg',
                    width: 280,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "You're set, Cinephile! 🎉",
                    style: constHeadingStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your account is good to go",
                    style: constSubStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ButtonIconComponent(
                    buttontext: "Let's Explore!",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                      );
                    },
                  ),
                ],
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

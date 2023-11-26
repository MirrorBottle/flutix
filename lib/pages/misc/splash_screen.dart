import 'dart:convert';

import 'package:flutix/globals.dart';
import 'package:flutix/models/user.dart';
import 'package:flutix/pages/auth/log_in_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutix/services/auth_service.dart';
import 'package:flutix/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutix/pages/misc/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    await Future.delayed(const Duration(seconds: 2)).then(
      (_) => goTo(),
    );
  }

  void goTo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirst = prefs.getBool('isFirst') ?? true;
    bool isLogin = prefs.getBool('isLogin') ?? false;
    if (isFirst) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else {
      if (isLogin) {
        String encodedAuth = prefs.getString('auth') ?? "{}";
        Map<String, dynamic> _auth = json.decode(encodedAuth);
        UserModel user = await UserService.getUser(_auth['id']);
        String _authData = json.encode(user.toMap());
        prefs.setString('auth', _authData);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LogInScreen()),
        );
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/splash.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              const Image(
                image: AssetImage('assets/images/logo_full_trans.png'),
                height: 200,
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Version 1.0.0',
                    style: constHeadingStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

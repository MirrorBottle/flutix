import 'package:firebase_core/firebase_core.dart';
import 'package:flutix/globals.dart';
import 'package:flutix/pages/auth/log_in_screen.dart';
import 'package:flutix/pages/auth/sign_up_screen.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutix/pages/misc/onboarding_screen.dart';
import 'package:flutix/pages/movie/movie_detail_screen.dart';
import 'package:flutix/pages/order/order_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutix/pages/misc/splash_screen.dart';
import 'package:flutix/pages/movie/movie_detail_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.white),
          inputDecorationTheme: const InputDecorationTheme(
            floatingLabelStyle: TextStyle(
              fontSize: 20,
              color: constPrimaryColor
            ),
            border: OutlineInputBorder(borderSide: BorderSide(color: kBorderColorTextField)),
            hintStyle: TextStyle(color: constPrimaryColor),
            labelStyle: TextStyle(color: constPrimaryColor),
            filled: true,
            fillColor: Colors.white70,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: kBorderColorTextField, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              borderSide: BorderSide(color: constPrimaryColor, width: 2),
            ),
          ),
        ),
        home: const LogInScreen());
  }
}

import 'package:flutix/components/button_component.dart';
import 'package:flutix/pages/auth/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutix/globals.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Light On,",
                      style: GoogleFonts.robotoSlab(
                          color: Colors.white, fontSize: 34)),
                  Text("Sign Up!",
                      style: GoogleFonts.robotoSlab(
                          color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold))
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: AppTextField(
                      textFieldType: TextFieldType.USERNAME,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Insert Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Masukkan password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ButtonComponent(
                    buttontext: 'Continue',
                    buttonDecoration: constButtonDecoration.copyWith(
                        color: constPrimaryColor),
                    // onPressed: _onPressedFunction,
                    onPressed: () async {},
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: const Text("Already have an account? Log In!",
                        style:
                            TextStyle(color: constPrimaryColor, fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                          context,
                          ConcentricPageRoute(
                              maintainState: false,
                              builder: (ctx) {
                                return const LogInScreen();
                              }));
                    },
                  )

                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

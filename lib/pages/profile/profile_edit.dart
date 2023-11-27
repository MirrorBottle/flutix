import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutix/components/button_component.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: constPrimaryColor,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(Icons.edit, color: Colors.black),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: constPrimaryColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            50,
                          ),
                        ),
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 347),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Full Name",
                      style: constTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 60.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Insert your full name",
                          hintStyle: constSecondaryTextStyle.copyWith(
                              color: constPrimaryColor, fontSize: 15),
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Email Address",
                      style: constTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 60.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Insert your email",
                          hintStyle: constSecondaryTextStyle.copyWith(
                              color: constPrimaryColor, fontSize: 15),
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("New Password",
                      style: constTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 60.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Insert your new password",
                          hintStyle: constSecondaryTextStyle.copyWith(
                              color: constPrimaryColor, fontSize: 15),
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Confirm Password",
                      style: constTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 60.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Confirm your new password",
                          hintStyle: constSecondaryTextStyle.copyWith(
                              color: constPrimaryColor, fontSize: 15),
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ButtonComponent(
                    buttontext: 'Update Now',
                    onPressed: () {},
                    invert: true,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            ),
          ]),
        ));
  }
}

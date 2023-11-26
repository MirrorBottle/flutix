import 'package:flutix/components/button_component.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();

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
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: constPrimaryColor,
              child: Icon(Icons.person, size: 40, color : Colors.white,),
            ),
            const SizedBox(height: 10,),
            Text("Reihan Al Sya'ban", style: constSecondaryTextStyle.copyWith(color: constPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("saban@rocketmail.com", style: constSecondaryTextStyle.copyWith(color: kGreyTextColor, fontSize: 14),),
            const SizedBox(height: 40),
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
                children: [
                  const SizedBox(height: 20,),
                  ListTile(
                    leading: const Icon(Icons.manage_accounts, color: Colors.white, size: 36,),
                    title: Text("Edit Profile", style: constTextStyle.copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text("Change your current profile", style: constSecondaryTextStyle.copyWith(color: Colors.white, fontSize: 12,),),
                    trailing: const Icon(Icons.navigate_next, color: Colors.white, size: 28,),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 36,),
                    title: Text("My Wallet", style: constTextStyle.copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text("See your balance", style: constSecondaryTextStyle.copyWith(color: Colors.white, fontSize: 12,),),
                    trailing: const Icon(Icons.navigate_next, color: Colors.white, size: 28,),
                  ),
                  ListTile(
                    leading: const Icon(Icons.translate, color: Colors.white, size: 36,),
                    title: Text("Change Languange", style: constTextStyle.copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text("Change current languange", style: constSecondaryTextStyle.copyWith(color: Colors.white, fontSize: 12,),),
                    trailing: const Icon(Icons.navigate_next, color: Colors.white, size: 28,),
                  ),
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.white, size: 36,),
                    title: Text("Help", style: constTextStyle.copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text("Find some help & support", style: constSecondaryTextStyle.copyWith(color: Colors.white, fontSize: 12,),),
                    trailing: const Icon(Icons.navigate_next, color: Colors.white, size: 28,),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star, color: Colors.white, size: 36,),
                    title: Text("Rate Our App", style: constTextStyle.copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text("Give us a rating", style: constSecondaryTextStyle.copyWith(color: Colors.white, fontSize: 12,),),
                    trailing: const Icon(Icons.navigate_next, color: Colors.white, size: 28,),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}

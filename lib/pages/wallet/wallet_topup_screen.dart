import 'dart:convert';

import 'package:flutix/components/button_component.dart';
import 'package:flutix/models/user.dart';
import 'package:flutix/pages/auth/log_in_screen.dart';
import 'package:flutix/pages/auth/sign_up/sign_up_genre_screen.dart';
import 'package:flutix/pages/auth/sign_up/sign_up_info_screen.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutix/pages/wallet/wallet_topup_success_screen.dart';
import 'package:flutix/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class WalletTopup extends StatefulWidget {
  const WalletTopup({Key? key}) : super(key: key);

  @override
  _WalletTopupState createState() => _WalletTopupState();
}

class _WalletTopupState extends State<WalletTopup>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  final TextEditingController amountController = TextEditingController();
  int selectedKotakIndex = -1;
  static final db = FirebaseFirestore.instance;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _handleSubmit() async {
    try {
      DocumentReference userRef = db.collection('users').doc(_auth!.id);
      await db.collection("transactions").add({
        "amount": amountController.text,
        "type": "topup",
        "users": userRef
      });
      await db.collection("users").doc(_auth!.id).update({
        "balance": FieldValue.increment(double.parse(amountController.text))
      });
      UserModel user = await UserService.getUser(_auth!.id);
      String _authData = json.encode(user.toMap());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth', _authData);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WalletTopupSuccess()),
      );
    } catch (e) {
      print(e);
    }
  }

  List<String> kotakValues = [
    "50000",
    "100000",
    "150000",
    "200000",
    "500000",
    "1000000",
  ];

  UserModel? _auth;

  void _init() async {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
    EasyLoading.show(status: 'Loading..', maskType: EasyLoadingMaskType.black);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedAuth = prefs.getString('auth') ?? "{}";
    setState(() {
      _auth = UserModel.fromJson(json.decode(encodedAuth));
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBgColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: kBgColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: constPrimaryColor),
        automaticallyImplyLeading: false,
        leading: const Padding(
          padding: EdgeInsets.only(top: 18.0, bottom: 18),
          child: BackButton(),
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
                  Text("Ready to,",
                      style: constTextStyle.copyWith(
                          color: constPrimaryColor, fontSize: 34)),
                  Text("Load Up?",
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
                  minHeight: MediaQuery.of(context).size.height - 226),
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
                  const SizedBox(height: 12),
                  Text("Type Amount",
                      style: constHeadingStyle.copyWith(
                          color: Colors.white, fontSize: 22)),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 60.0,
                    child: TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'Rp. ',
                        hintText: 'Insert Amount',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text("Or, Choose Below",
                      style: constHeadingStyle.copyWith(
                          color: Colors.white, fontSize: 22)),
                  const SizedBox(height: 15),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Sekarang ada 2 kolom dalam grid
                    ),
                    shrinkWrap:
                        true, // Membungkus GridView dalam SingleChildScrollView
                    physics:
                        const NeverScrollableScrollPhysics(), // Untuk mencegah scroll GridView
                    itemCount: kotakValues.length, // Jumlah kotak dalam grid
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedKotakIndex =
                                index; // Menyimpan indeks kotak yang dipilih
                            amountController.text = kotakValues[index];
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: 50, // Mengatur lebar kotak
                          height: 50, // Mengatur tinggi kotak
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  12.0), // Menambahkan lengkungan pada sisi kotak
                              color: selectedKotakIndex == index
                                  ? Colors.white
                                  : const Color(
                                      0xFF00419d) // Warna kotak tergantung pada pemilihan
                              ),
                          child: Center(
                            child: Text(
                              "IDR\n ${kotakValues[index]}", // Mengambil nilai dari list
                              style: constNumberTextStyle.copyWith(
                                  color: selectedKotakIndex == index
                                      ? const Color(0xFF00419d)
                                      : const Color(0xFFF5c76b),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  ButtonIconComponent(
                    buttontext: "Continue",
                    invert: true,
                    onPressed: _handleSubmit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

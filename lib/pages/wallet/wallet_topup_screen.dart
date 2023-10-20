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
import 'package:nb_utils/nb_utils.dart';

class WalletTopup extends StatefulWidget {
  const WalletTopup({Key? key}) : super(key: key);

  @override
  _WalletTopupState createState() => _WalletTopupState();
}

class _WalletTopupState extends State<WalletTopup>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();

  var _selectedIndex = 1;
  final _headlines = [
    ["Ready to,", "Load Up?"],
    ["Pick Your", "Poisons..."],
    ["All Set,", "Ready to Go?"]
  ];
  int selectedKotakIndex = -1;

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

  List<String> kotakValues = [
    "IDR 50.000",
    "IDR 100.000",
    "IDR 150.000",
    "IDR 200.000",
    "IDR 500.000",
    "IDR 1.000.000",
  ];

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
                          color: constPrimaryColor, fontSize: 34)),
                  Text(_headlines[_selectedIndex - 1][1],
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
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'Rp. 0',
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Sekarang ada 2 kolom dalam grid
                    ),
                    shrinkWrap:
                        true, // Membungkus GridView dalam SingleChildScrollView
                    physics:
                        NeverScrollableScrollPhysics(), // Untuk mencegah scroll GridView
                    itemCount: kotakValues.length, // Jumlah kotak dalam grid
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedKotakIndex =
                                index; // Menyimpan indeks kotak yang dipilih
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          width: 50, // Mengatur lebar kotak
                          height: 50, // Mengatur tinggi kotak
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                12.0), // Menambahkan lengkungan pada sisi kotak
                            color: selectedKotakIndex == index
                                ? Colors.white
                                : Color(0xFF00419d) // Warna kotak tergantung pada pemilihan
                          ),
                          child: Center(
                            child: Text(
                              kotakValues[index], // Mengambil nilai dari list
                              style: constNumberTextStyle.copyWith(
                                color: selectedKotakIndex == index
                                ? Color(0xFF00419d)
                                : Color(0xFFF5c76b),
                                fontSize: 24,
                                fontWeight: FontWeight.bold)
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                      );
                    },
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

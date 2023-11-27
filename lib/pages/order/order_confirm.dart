import 'package:flutix/components/button_component.dart';
import 'package:flutix/pages/auth/sign_up_screen.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:provider/provider.dart';

class CastCard extends StatelessWidget {
  final Map<String, String> data;
  const CastCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              clipBehavior: Clip.antiAlias,
              color: constPrimaryColor,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 100,
                  height: 130,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 100,
              child: Text(data["name"]!,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: constSecondaryTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 100,
              child: Text(data["character"]!,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: constSecondaryTextStyle.copyWith(
                      color: Colors.white, fontSize: 14)),
            )
          ]),
        ));
  }
}

class OrderConfirmScreen extends StatefulWidget {
  const OrderConfirmScreen({Key? key}) : super(key: key);

  @override
  _OrderConfirmScreenState createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ticketData, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: constPrimaryColor,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          titleSpacing: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 18),
            child: BackButton(
              onPressed: () {},
            ),
          ),
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            // * BACKDROP
            Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://www.themoviedb.org/t/p/original/j2LJCbVXPOFr71oHV9izq2OBSyg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                top: 0),

            // * BACKDROP OVERLAY

            Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[constPrimaryColor, Colors.transparent]),
                  ),
                ),
                top: 0),
            // * POSTER
            Positioned(
                top: 100,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        clipBehavior: Clip.antiAlias,
                        color: constPrimaryColor,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://www.themoviedb.org/t/p/original/lVW67w7eWwmBhbBCc4f983pO8m6.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 130,
                          height: 195,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Paper Towns",
                                style: constHeadingStyle.copyWith(
                                    color: Colors.white, fontSize: 28)),
                            const SizedBox(height: 10),
                            Text("Bigmall XXI 21",
                                style: constSecondaryTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text("Sat 22, 12:00",
                                style: constSecondaryTextStyle.copyWith(
                                    color: Colors.white, fontSize: 15)),
                            const SizedBox(height: 15),
                          ],
                        ),
                      )
                    ],
                  ),
                )),

            // * MAIN CONTENT
            Positioned(
                top: 320,
                bottom: 60,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20.0),
                  height: 1000,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    color: constPrimaryColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Detail",
                            style: constHeadingStyle.copyWith(
                                color: Colors.white, fontSize: 22)),
                        const SizedBox(height: 15),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "Seats",
                            style: constTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text("C1, C2",
                              style: constLabelNumberTextStyle.copyWith(
                                  color: constTernaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "Ticket(s)",
                            style: constTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text("Rp. 120.000 x2",
                              style: constNumberTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "Fees",
                            style: constTextStyle.copyWith(
                                color: constTernaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text("Rp. 10.000",
                              style: constNumberTextStyle.copyWith(
                                  color: constTernaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "Total",
                            style: constTextStyle.copyWith(
                                color: constTernaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text("Rp. 260.000",
                              style: constNumberTextStyle.copyWith(
                                  color: constTernaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "Saldo Wallet",
                            style: constTextStyle.copyWith(
                                color: constSuccessColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text("Rp. 160.000",
                              style: constNumberTextStyle.copyWith(
                                  color: constSuccessColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ButtonIconComponent(
                buttontext: "Checkout Now",
                invert: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}

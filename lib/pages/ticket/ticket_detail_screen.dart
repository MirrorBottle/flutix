import 'package:flutix/components/button_component.dart';
import 'package:flutix/pages/auth/sign_up_screen.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class TicketDetailScreen extends StatefulWidget {
  const TicketDetailScreen({Key? key}) : super(key: key);

  @override
  _TicketDetailScreenState createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<Map<String, String>> _casts = [
    {
      "name": "Nat Wolff",
      "character": "Quentin",
      "image":
          "https://www.themoviedb.org/t/p/w138_and_h175_face/g9noCweddwSb3VBSRpX3vo7TbuP.jpg"
    },
    {
      "name": "Cara Delevingne",
      "character": "Margo",
      "image":
          "https://www.themoviedb.org/t/p/w138_and_h175_face/fxpve7evj6H1kl8rTnDqNyIdObI.jpg"
    },
    {
      "name": "Austin Abrams",
      "character": "Ben",
      "image":
          "https://www.themoviedb.org/t/p/w138_and_h175_face/9pSpSAk9NsYC5puqAVsmSK3OSeu.jpg"
    },
    {
      "name": "Halston Sage",
      "character": "Lacey",
      "image":
          "https://www.themoviedb.org/t/p/w138_and_h175_face/lFQog3AzxHXAteUz8n2PIJsLQbe.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
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
                          Text("Jake Schreir",
                              style: constSecondaryTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text("07/24/2015 • 1h 49m",
                              style: constSecondaryTextStyle.copyWith(
                                  color: Colors.white, fontSize: 15)),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text("8.3",
                                  style: constNumberTextStyle.copyWith(
                                      color: constTernaryColor, fontSize: 20)),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.star,
                                color: constTernaryColor,
                              ),
                              const Icon(
                                Icons.star,
                                color: constTernaryColor,
                              ),
                              const Icon(
                                Icons.star,
                                color: constTernaryColor,
                              ),
                              const Icon(
                                Icons.star,
                                color: constTernaryColor,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.grey,
                              )
                            ],
                          )
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
                      Text("Ticket Details",
                          style: constHeadingStyle.copyWith(
                              color: Colors.white, fontSize: 22)),
                      const SizedBox(height: 15),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Text(
                          "Cinema",
                          style: constTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text("Paris Van Java Mall",
                            style: constSecondaryTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Text(
                          "Date & Time",
                          style: constTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text("Sat 21/04, 12:00",
                            style: constSecondaryTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Text(
                          "Price /pcs",
                          style: constTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text("IDR. 50.000",
                            style: constNumberTextStyle.copyWith(
                                color: constTernaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Text(
                          "Seat",
                          style: constTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text("C1, C2",
                            style: constSecondaryTextStyle.copyWith(
                                color: constTernaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama",
                                style: constTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Fahmi Fitnanda",
                                style: constSecondaryTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                "Nama",
                                style: constTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "IDR. 100.000",
                                style: constNumberTextStyle.copyWith(
                                  color: constTernaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/QR1.png',
                                width: 105,
                              ),
                              SizedBox(height: 5),
                              Text("ID A20230121",
                                  style: constSecondaryTextStyle.copyWith(
                                    color: kBgColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: constSecondaryColor,
                ),
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text("Dwonload Invoice",
                    style: constTextStyle.copyWith(
                        color: constTernaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
              ))
        ],
      ),
    );
  }
}

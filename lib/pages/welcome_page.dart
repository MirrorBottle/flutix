import 'package:flutter/material.dart';
import 'package:flutix/misc/colors.dart';
import 'package:flutix/widgets/app_text.dart';
import 'package:flutix/widgets/app_text_large.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = ["welcome-one.png", "welcome-two.png", "welcome-three.png"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Container(
                  margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextLarge(text: "Trips"),
                          AppText(
                            text: "Mountain",
                            size: 30,
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            width: 250,
                            child: AppText(
                                text:
                                    "Maountain hikes give you an incredible sense of freedom along with endurance tests",
                                color: AppColors.textColor2,
                                size: 14),
                          )
                        ],
                      )
                    ],
                  )),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/" + images[index]),
                      fit: BoxFit.cover)),
            );
          }),
    );
  }
}

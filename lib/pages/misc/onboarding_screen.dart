import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutix/globals.dart';
import 'package:flutix/pages/auth/log_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

final pages = [
  const PageData(
    icon: Icons.movie,
    title: "Find Movies\nFast",
    bgColor: Color(0xFF062c62),
    iconColor: Colors.white,
    textColor: Colors.white,
  ),
  const PageData(
    icon: Icons.timer,
    title: "Book in \nSeconds",
    iconColor: Colors.white,
    bgColor: Color(0xFFfada9c),
  ),
  const PageData(
    icon: Icons.swipe,
    title: "Swipe for \nTickets",
    textColor: Color(0xFF062c62),
    iconColor: Colors.white,
    bgColor: Color.fromARGB(255, 255, 255, 255),
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  void _handleFinish() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirst', false);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
          colors: pages.map((p) => p.bgColor).toList(),
          radius: screenWidth * 0.1,
          // curve: Curves.ease,
          itemCount: pages.length,
          nextButtonBuilder: (context) => Padding(
                padding: const EdgeInsets.only(left: 3), // visual center
                child: Icon(
                  Icons.navigate_next,
                  size: screenWidth * 0.08,
                ),
              ),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (index) {
            final page = pages[index % pages.length];
            return SafeArea(
              child: _Page(page: page),
            );
          },
          onFinish: _handleFinish),
    );
  }
}

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final Color iconColor;

  const PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Column(
      children: [
        space(10),
        _Image(
          page: page,
          size: 190,
          iconSize: 170,
        ),
        space(8),
        _Text(
          page: page,
          style: TextStyle(
            fontSize: screenHeight * 0.046,
          ),
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    Key? key,
    required this.page,
    this.style,
  }) : super(key: key);

  final PageData page;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      page.title ?? '',
      style: constHeadingStyle.copyWith(
        color: page.textColor,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        fontSize: 18,
        height: 1.2,
      ).merge(style),
      textAlign: TextAlign.center,
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
    required this.page,
    required this.size,
    required this.iconSize,
  }) : super(key: key);

  final PageData page;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(80.0)),
        color: HSLColor.fromColor(page.bgColor).withLightness(0.4).toColor(),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Icon(
            page.icon,
            size: iconSize,
            color: page.iconColor,
          ),
        ],
      ),
    );
  }
}

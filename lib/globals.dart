import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const constPrimaryColor = Color(0xFF002c6a);
const constSecondaryColor = Color(0xFF00419d);
const constTernaryColor = Color(0xFFF5c76b);
const constDangerColor = Color(0xFFC03221);
const constSuccessColor = Color(0xFFD1E7C6);
const constWarningColor = Color(0xFFFFF07C);



const kMainColor = Color(0xff2dba4e);
const kGreyTextColor = Color(0xFF9090AD);
const kBorderColorTextField = Color(0xFFC2C2C2);
const kDarkWhite = Color(0xFFF1F7F7);
const kTitleColor = Color(0xFF002c6a);
const kAlertColor =  Color(0xFF002c6a);
const kBgColor =  Color(0xFFFAFAFA);
const kHalfDay = Color(0xFFE8B500);
const kGreenColor = Color(0xFF08BC85);


final kTextStyle = GoogleFonts.robotoSlab(
  color: kTitleColor,
);

final constSecondaryTextStyle = GoogleFonts.raleway();
final constNumberTextStyle = GoogleFonts.oswald();
final constLabelNumberTextStyle = GoogleFonts.openSans();
final constTextStyle = GoogleFonts.robotoSlab(
  color: constPrimaryColor
);

final constHeadingStyle = GoogleFonts.robotoSlab(
  color: constPrimaryColor,
  fontSize: 24,
  textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
  )
);

final constSubStyle = GoogleFonts.raleway(
  color: Colors.grey,
  fontSize: 15,
);

final constListTitleStyle = GoogleFonts.robotoSlab(
  color: Colors.black,
  fontSize: 16,
  textStyle: const TextStyle(
    fontWeight: FontWeight.w600,
  )
);

const constButtonDecoration = BoxDecoration(
  color: constPrimaryColor,
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

final constPrimaryButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(constPrimaryColor),
  padding: MaterialStateProperty.all(const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
);

final constDangerButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(constDangerColor),
  padding: MaterialStateProperty.all(const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
);

final constSuccessButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(constSuccessColor),
  padding: MaterialStateProperty.all(const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
);

final constInputLabelStyle = GoogleFonts.robotoSlab(
  fontSize: 17,
);
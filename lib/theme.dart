import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 30.0;

Color whiteTextColor = Color(0xffF1F0F2);
Color blackTextColor = Color(0xff232323);
Color greyTextColor = Color(0xff666666);
Color primaryColor = Color(0xff619B8A);
Color secondaryColor = Color(0xff233D4D);
Color backgroundColor = Color(0xffF3F3F3);
Color alertColor = Color(0xffED6363);
Color transparentColor = Colors.transparent;

TextStyle whiteTextStyle = GoogleFonts.inter(
  color: whiteTextColor,
);
TextStyle blackTextStyle = GoogleFonts.inter(
  color: blackTextColor,
);
TextStyle greyTextStyle = GoogleFonts.inter(
  color: greyTextColor,
);
TextStyle alertTextStyle = GoogleFonts.inter(
  color: alertColor,
);
TextStyle buttonTextStyle = GoogleFonts.inter(
  color: secondaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

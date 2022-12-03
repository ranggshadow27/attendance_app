import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle interLight = GoogleFonts.inter(fontWeight: FontWeight.w300);
TextStyle interMedium = GoogleFonts.inter(fontWeight: FontWeight.w500);
TextStyle interSemiBold = GoogleFonts.inter(fontWeight: FontWeight.w600);
TextStyle interBold = GoogleFonts.inter(fontWeight: FontWeight.w700);

Color greyColor = Color(0xFFE6E6E6);
Color darkGreyColor = Color(0xFF808489);
Color lightGreyColor = Color(0xFFF8F8F8);
Color primaryGreenColor = Color(0xFF143642);
Color darkGreenColor = Color(0xFF08121E);
Color lightBorderColor = Color(0xFFA2AEBC);
Color redColor = Color(0xFFD9594C);
Color lightRedColor = Color(0xFFFFADA5);
Color greenColor = Color(0xFF5FA38A);
Color lightGreenColor = Color(0xFFC5D8D1);

TextField passwordTextField = TextField(
  enableInteractiveSelection: false,
  cursorColor: darkGreenColor,
  style: interMedium.copyWith(color: darkGreenColor),
  decoration: InputDecoration(
    prefixIcon: Icon(FontAwesomeIcons.lock, color: primaryGreenColor, size: 20),
    labelText: "password",
    suffixIcon: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      child:
          Icon(FontAwesomeIcons.eyeSlash, color: primaryGreenColor, size: 20),
    ),
    labelStyle: interMedium.copyWith(fontSize: 16, color: lightBorderColor),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightBorderColor),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: darkGreenColor),
      borderRadius: BorderRadius.circular(12),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

double getMediaQueryWidth(double number, BuildContext context) {
  return MediaQuery.of(context).size.width * number;
}

double getMediaQueryHeight(double number, BuildContext context) {
  return MediaQuery.of(context).size.height * number;
}

Widget explore(
  BuildContext context,
  String text,
  Widget page,
) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
          vertical: getMediaQueryHeight(0.02, context),
          horizontal: getMediaQueryWidth(0.06, context)),
      backgroundColor: const Color(0xFFEE403D),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SvgPicture.asset(
          'assets/arrowright.svg',
        ),
      ],
    ),
  );
}

Widget getText(String text) {
  return Text(
    text,
    style: GoogleFonts.spaceGrotesk(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    maxLines: 2,
    textDirection: TextDirection.ltr,
  );
}

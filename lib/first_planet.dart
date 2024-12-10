import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planets/home_planets.dart';
import 'package:planets/widgets/widgets.dart';

class FirstPlanet extends StatelessWidget {
  const FirstPlanet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0E0E0E),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/splashplanet.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                horizontal: getMediaQueryWidth(
                  0.025,
                  context,
                ),
              ),
              child: Text(
                'Explore\nThe\nUniverse',
                style: GoogleFonts.inter(
                  fontSize: 48,
                  height: 1.3,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Positioned(
              bottom: getMediaQueryHeight(0.02, context),
              left: getMediaQueryWidth(0.03, context),
              right: getMediaQueryWidth(0.03, context),
              child: explore(context, 'Explore', HomePlanets()),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planets/planetbio.dart';
import 'package:planets/widgets/widgets.dart';

class HomePlanets extends StatefulWidget {
  const HomePlanets({super.key});

  @override
  State<HomePlanets> createState() => _HomePlanetsState();
}

class _HomePlanetsState extends State<HomePlanets> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    const List<String> planets = [
      'Sun',
      'Mercury',
      'Venus',
      'Earth',
      'Mars',
      'Jupiter',
      'Saturn',
      'Uranus',
      'Neptune',
    ];
    final pageController = PageController();

    void changePage(int currentIndex) {
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }

    void goToPage() {
      if (currentIndex < planets.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
        pageController.jumpToPage(0);
      }
      changePage(currentIndex);
      setState(() {});
    }

    void backPage() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = planets.length - 1;
        pageController.jumpToPage(planets.length - 1);
      }
      changePage(currentIndex);
      setState(() {});
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          getMediaQueryHeight(0.25, context),
        ),
        child: AppBar(
          backgroundColor: const Color(0xFF0E0E0E),
          flexibleSpace: Stack(
            children: [
              Positioned(
                child: Transform.rotate(
                  angle: 3.14159,
                  child: Image.asset(
                    'assets/moon.jpeg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(14, 14, 14, 0),
                        Color.fromRGBO(14, 14, 14, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    top: getMediaQueryHeight(0.02, context),
                  ),
                  child: getText(
                    'Explore',
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: getMediaQueryWidth(0.05, context),
                child: getText(
                  'Which planet\nwould you like to explore?',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: getMediaQueryHeight(0.04, context),
          ),
          SizedBox(
            height: getMediaQueryHeight(0.45, context),
            child: PageView.builder(
              onPageChanged: (value) {
                currentIndex = value;
                setState(() {});
              },
              controller: pageController,
              itemCount: planets.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Image.asset(
                  'assets/${planets[index].toLowerCase()}.png',
                );
              },
            ),
          ),
          SizedBox(
            height: getMediaQueryHeight(0.02, context),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getMediaQueryHeight(0.02, context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getNavigateButton('arrowleft', context, backPage),
                getText(planets[currentIndex]),
                getNavigateButton('arrowright', context, goToPage),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getMediaQueryWidth(0.02, context),
              vertical: getMediaQueryHeight(0.02, context),
            ),
            child: explore(
              context,
              'Explore ${planets[currentIndex]}',
              PlanetBio(
                currentIndex: currentIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getNavigateButton(
      String text, BuildContext context, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: const Color(0xFFEE403D),
        radius: getMediaQueryHeight(0.03, context),
        child: SvgPicture.asset(
          'assets/$text.svg',
        ),
      ),
    );
  }
}

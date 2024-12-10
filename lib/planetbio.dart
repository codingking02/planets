import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:planets/model/planet.dart';
import 'package:planets/widgets/widgets.dart';

class PlanetBio extends StatefulWidget {
  PlanetBio({super.key, required this.currentIndex});
  int currentIndex;

  @override
  State<PlanetBio> createState() => _PlanetBioState();
}

class _PlanetBioState extends State<PlanetBio> {
  List<Planet> planets = [];

  @override
  void initState() {
    super.initState();
    loadPlanetData();
  }

  Future<void> loadPlanetData() async {
    ByteData data = await rootBundle.load('assets/solarsystem.xlsx');
    var bytes = data.buffer.asUint8List();

    var excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables[excel.tables.keys.first]!;
    for (var i = 1; i < sheet.maxRows; i++) {
      var row = sheet.rows[i];
      planets.add(Planet.fromExcelRow(row));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (planets.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0E0E0E),
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ),
      );
    }
    return Scaffold(
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
                    planets[widget.currentIndex].name,
                  ),
                ),
              ),
              Positioned(
                left: getMediaQueryWidth(0.03, context),
                bottom: getMediaQueryHeight(0.03, context),
                child: SizedBox(
                  width: getMediaQueryWidth(0.7, context),
                  child: getText(
                    planets[widget.currentIndex].title,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0E0E0E),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getMediaQueryHeight(0.02, context),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: getMediaQueryHeight(0.02, context),
              ),
              SizedBox(
                height: getMediaQueryHeight(0.5, context),
                width: double.infinity,
                child: ModelViewer(
                  src: 'assets/${planets[widget.currentIndex].model3D}',
                  ar: true,
                  loading: Loading.auto,
                  autoPlay: true,
                  autoRotate: true,
                  cameraControls: true,
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(0.04, context),
              ),
              getText(
                'About',
              ),
              SizedBox(
                height: getMediaQueryHeight(0.02, context),
              ),
              Text(
                planets[widget.currentIndex].about,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(0.02, context),
              ),
              Wrap(
                runSpacing: getMediaQueryHeight(0.02, context),
                children: [
                  getInfo(
                      'Distance from Sun (km) : ${planets[widget.currentIndex].distanceFromSun}'),
                  getInfo(
                      'Length of Day (hours) : ${planets[widget.currentIndex].lengthOfDay}'),
                  getInfo(
                      'Orbital Period (Earth years) : ${planets[widget.currentIndex].orbitalPeriod}'),
                  getInfo(
                      'Radius (km) : ${planets[widget.currentIndex].radius}'),
                  getInfo('Mass (kg) : ${planets[widget.currentIndex].mass}'),
                  getInfo(
                      'Gravity (m/s²) : ${planets[widget.currentIndex].density}'),
                  getInfo(
                    'Surface Area (km²) : ${planets[widget.currentIndex].surfaceArea}',
                  ),
                ],
              ),
              SizedBox(
                height: getMediaQueryHeight(0.04, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget getInfo(String text) {
  return Text(
    text,
    style: GoogleFonts.spaceGrotesk(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  );
}

import 'package:excel/excel.dart';

class Planet {
  final String name;
  final String pngImage;
  final String model3D;
  final String title;
  final String about;
  final String distanceFromSun;
  final String lengthOfDay;
  final String orbitalPeriod;
  final String radius;
  final String mass;
  final String density;
  final String surfaceArea;

  // Constructor
  Planet({
    required this.name,
    required this.pngImage,
    required this.model3D,
    required this.title,
    required this.about,
    required this.distanceFromSun,
    required this.lengthOfDay,
    required this.orbitalPeriod,
    required this.radius,
    required this.mass,
    required this.density,
    required this.surfaceArea,
  });

  factory Planet.fromExcelRow(List<Data?> row) {
    return Planet(
      name: row[0]?.value.toString() ?? '',
      pngImage: row[1]?.value.toString() ?? '',
      model3D: row[2]?.value.toString() ?? '',
      title: row[3]?.value.toString() ?? '',
      about: row[4]?.value.toString() ?? '',
      distanceFromSun: row[5]?.value.toString() ?? '0',
      lengthOfDay: row[6]?.value.toString() ?? '0',
      orbitalPeriod: row[7]?.value.toString() ?? '0',
      radius: row[8]?.value.toString() ?? '0',
      mass: row[9]?.value.toString() ?? '0',
      density: row[10]?.value.toString() ?? '0',
      surfaceArea: row[11]?.value.toString() ?? '0',
    );
  }
}

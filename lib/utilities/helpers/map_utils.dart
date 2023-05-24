import 'package:map_launcher/map_launcher.dart';
import 'dart:developer' as dev;

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude,
      {String location = ""}) async {
    final availableMaps = await MapLauncher.installedMaps;
    dev.log(
      availableMaps.toString(),
    ); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(latitude, longitude),
      title: location,
    );
  }
}

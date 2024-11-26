// ignore_for_file: non_constant_identifier_names
import 'package:geolocator/geolocator.dart';

class GpsController {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Periksa apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Layanan lokasi tidak aktif
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }

    // Periksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Izin ditolak
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Izin ditolak secara permanen
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Ambil posisi jika layanan dan izin sudah tersedia
    return await Geolocator.getCurrentPosition();
}

}

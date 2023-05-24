import 'package:geolocator/geolocator.dart';

class LocationHelper {
  Future<Position> checkAndGetLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;
    Position? position;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      // RemoveFavouritePopUp()
      //     .errorPopUp(context, "Location services are disabled!");
      return position!;
    } else {
      print('serviceEnabled');
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      print(permission);
      if (permission != LocationPermission.denied) {
        print('access granted');
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );

        return position;
      } else {
        return position!;
      }
    }
  }

  // Future<String> getAddressFromPosition(position) async {
  //   try {
  //     List placeMarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);
  //     Placemark place = placeMarks[0];
  //     print("Address $place");
  //     String street = place.street!;
  //     String area = place.administrativeArea!;

  //     //  print(userAddress);
  //     return street + ',' + area;
  //   } catch (e) {
  //     return "";
  //   }
  // }

  // Future<LocationDataModel> manageLocation() async {
  //   LocationDataModel? _locationDataModel;
  //   try {
  //     Position position = await checkAndGetLocation();
  //     String address = await getAddressFromPosition(position);
  //     if (address.isEmpty) {
  //       _locationDataModel = LocationDataModel(
  //           status: false, message: "some error occured", address: "");
  //       return _locationDataModel;
  //     } else {
  //       _locationDataModel = LocationDataModel(
  //           status: true, message: "success", address: address);
  //       return _locationDataModel;
  //     }
  //   } catch (e) {
  //     print(e);
  //     _locationDataModel = LocationDataModel(
  //         status: false, message: "some error occured", address: "");
  //     return _locationDataModel;
  //   }
  // }
}

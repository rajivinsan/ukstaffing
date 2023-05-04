// import 'package:flutter/material.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:google_place/google_place.dart' as gplace;
// import 'package:location/location.dart';
// //import 'package:geolocator/geolocator.dart';
// import 'dart:async';
// import 'package:permission_handler/permission_handler.dart' as handler;

// const kGoogleApiKey = "AIzaSyC1cXbdBcORyiY0Yo4Rfc6641MtmRlUIq8";

// class LocationUtil {
//   static Future<bool> requestPermission() async {
//     final status = await handler.Permission.location.request();
//     if (status.isGranted) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static Future<LocationData> getPosition() async {
//     // Position position = await Geolocator.getCurrentPosition(
//     //     desiredAccuracy: LocationAccuracy.high);
//     // return position;
//     Location location = new Location();

//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     LocationData? _locationData;
//     try {
// // _serviceEnabled = await location.serviceEnabled();
// // if (!_serviceEnabled) {
// //   _serviceEnabled = await location.requestService();
// //   if (!_serviceEnabled) {
// //     return;
// //   }
// // }

// // _permissionGranted = await location.hasPermission();
// // if (_permissionGranted == PermissionStatus.denied) {
// //   _permissionGranted = await location.requestPermission();
// //   if (_permissionGranted != PermissionStatus.granted) {
// //     return;
// //   }
// // }

//       _locationData = await location.getLocation();
//     } catch (e) {
//       print(e);
//     }
//     print("${_locationData!.latitude} ${_locationData.longitude}");
//     return _locationData;
//   }

//   static Future<String> getAddress(
//       {@required double? lat, @required double? lng}) async {
//     var coordinates = new Coordinates(lat, lng);
//     var first = "";

//     try {
//       await Geocoder.google(kGoogleApiKey)
//           .findAddressesFromCoordinates(coordinates)
//           .then((value) {
//         first = "${value.first.addressLine}";
//         print(value.first.addressLine);

//         return first;
//       });
//     } catch (e) {
//       print(e);
//     }

//     //  print("${first.featureName} : ${first.addressLine}");
//     return first.toString();
//   }

//   static Future<bool> checkPermssion() async {
//     var status = await handler.Permission.location.status;
//     if (status.isLimited) {
//       bool per = await requestPermission();
//       return per;
//     } else if (status.isGranted) {
//       return true;
//     } else if (status.isDenied) {
//       return false;
//     } else if (status.isPermanentlyDenied) {
//       handler.openAppSettings();
//       return false;
//     } else {
//       return false;
//     }
//   }

//   // googlePlace;

//   gplace.GooglePlace googlePlace = gplace.GooglePlace(kGoogleApiKey);

//   Future<List<gplace.AutocompletePrediction>> autoCompleteSearch(
//       String value) async {
//     List<gplace.AutocompletePrediction>? predictions = [];
//     var result = await googlePlace.autocomplete.get(value);
//     if (result != null && result.predictions != null) {
//       predictions = result.predictions;
//       return predictions!;
//     }
//     return predictions;
//   }

//   Future<gplace.DetailsResult> getPlaceDetils(String placeId) async {
//     gplace.DetailsResult? detailsResult;
//     var result = await this.googlePlace.details.get(placeId);
//     if (result != null && result.result != null) {
//       detailsResult = result.result!;
//       return detailsResult;
//     }
//     return detailsResult!;
//   }
// }


// //smE4CEVF0hVMAa0WmgMOVKIiSSc=
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sterling/constants/app_constant.dart';
import 'package:sterling/models/auth/detail_listing_model.dart';
import 'package:sterling/views/auth/professionDetail/training/training_page.dart';

class LocaldbHelper {
  static SharedPreferences? prefs;

  static Future saveUserName({@required String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", name!);
  }

  static Future<String?> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("username")) {
      return sharedPreferences.getString("username");
    }
    return null;
  }

  static Future saveToken({@required String? token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token!);
  }

  static Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("token")) {
      return sharedPreferences.getString("token");
    }
    return null;
  }

  static Future saveSignup({@required bool? isSignUp}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isSignUp", isSignUp!);
  }

  static Future<bool?> isSignUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("isSignUp")) {
      return sharedPreferences.getBool("isSignUp");
    }
    return false;
  }

  static Future saveListingDetails(
      {required List<ProfessionDetailsModel> list}) async {
    final String encodedData = ProfessionDetailsModel.encode(list);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("listing", encodedData);
  }

  static Future<List<ProfessionDetailsModel>> getLisitingDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("listing")) {
      String? list = sharedPreferences.getString("listing");
      final List<ProfessionDetailsModel> listing =
          ProfessionDetailsModel.decode(list!);
      return listing;
    }
    return professionalListing;
  }

  static Future<List<CertificateModel>> getTraingLisitingDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("trainglisting")) {
      String? list = sharedPreferences.getString("trainglisting");
      final List<CertificateModel> listing = CertificateModel.decode(list!);
      return listing;
    }
    return certificationList;
  }

  static Future saveTrainingListingDetails(
      {required List<CertificateModel> list}) async {
    final String encodedData = CertificateModel.encode(list);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("trainglisting", encodedData);
  }

  static removeAllSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    final data = sharedPreferences.getString("listing");
    return true;
    //print(data);
  }

  // save selected location

}

import 'dart:convert';

import 'package:sterling/models/auth/work_experience.dart';
import 'package:sterling/repository/APIBase/api_response.dart';
import 'package:sterling/repository/APIBase/apiFunction.dart';
import 'package:sterling/repository/APIBase/api_url.dart';
import 'package:sterling/repository/auth/auth_repository.dart';

import '../../services/local_db_helper.dart';
import 'dart:developer' as dev;

class AuthRepositoryImpl implements AuthRepository {
  final ApiFunction api;
  AuthRepositoryImpl({required this.api});

  ///register first time user
  @override
  Future<APIResponse> userRegistration(data) async {
    try {
      final response = await api.post(ApiUrl.signUp, headers: {}, body: data);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  ///functi
  @override
  Future<APIResponse> userPersonalDetails(
      {required String address,
      required String gender,
      required String dob,
      required String conuntry,
      required String mobile}) async {
    final token = await LocaldbHelper.getToken();
    final cid = int.parse(token!);
    var body = jsonEncode({
      "address": address,
      "gender": gender,
      "dob": dob,
      "country": "Ind",
      "mobile": mobile,
      "cid": cid
    });

    try {
      final response = await api.post(ApiUrl.personalDetails, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  ///add worke experiece of the customer
  ///take list of work experience model
  @override
  Future<APIResponse> addWorkExperience(
      {required List<WorkExperienceModel> list}) async {
    final List<Map<String, dynamic>> body = [];
    Map<String, dynamic> map = {};
    for (int i = 0; i < list.length; i++) {
      map.addAll({
        "emloyer": list[i].employerName,
        "dateFrom": list[i].startDate,
        "dateTo": list[i].endDate,
        "cid": list[i].cid
      });
      body.add(map);
    }
    dev.log(body.toString());

    try {
      final response = await api.post(ApiUrl.addWorkExperience, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse> updateBankDetails(
      {required String nin,
      required String bankCode,
      required String name,
      required String accNo}) async {
    final String? token = await LocaldbHelper.getToken();
    Map<String, dynamic> body = {
      "nin": nin,
      "name": name,
      "bankCode": bankCode,
      "acNo": accNo,
      "cid": int.parse(token!)
    };
    try {
      final response = await api.post(ApiUrl.bankDetails, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse> postKin(
      {required String kinNmae,
      required String kinPhone,
      required String relation}) async {
    final String? token = await LocaldbHelper.getToken();
    try {
      Map<String, dynamic> body = {
        "kinName": kinNmae,
        "kinPhone": kinPhone,
        "relation": relation,
        "cid": int.parse(token!)
      };
      final response = await api.post(ApiUrl.nextOfKin, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse> posIdBadge({required String photo}) async {
    final String? token = await LocaldbHelper.getToken();
    try {
      Map<String, dynamic> body = {"photo": photo, "cid": int.parse(token!)};
      final response = await api.post(ApiUrl.idBadge, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse> addReference(
      {required String employer,
      required String orginisation,
      required String startDate,
      required String? endDate}) async {
    final String? token = await LocaldbHelper.getToken();
    try {
      Map<String, dynamic> body = {
        "employer": employer,
        "organisation": orginisation,
        "startDate": startDate,
        if (endDate != null) "endDate": endDate,
        "cid": int.parse(token!)
      };
      final response = await api.post(ApiUrl.references, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse> backgroundChecks(
      {required String accountName,
      required String doc,
      required String date}) async {
    final String? token = await LocaldbHelper.getToken();
    try {
      Map<String, dynamic> body = {
        "accountName": accountName,
        "doc": doc,
        "date": date,
        "cid": int.parse(token!)
      };
      final response = await api.post(ApiUrl.backgroundCheck, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse> postNmc(
      {required String date,
      required String nmcPin,
      required String nurseType}) async {
    final String? token = await LocaldbHelper.getToken();
    try {
      Map<String, dynamic> body = {
        "date": date,
        "pin": nmcPin,
        "type": nurseType,
        "cid": int.parse(token!)
      };
      final response = await api.post(ApiUrl.backgroundCheck, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse> postEmployerQuery(
      {required String name,
      required String email,
      required String phone,
      required String profession,
      required String message,
      required String urls,
      required int type}) async {
    try {
      Map<String, dynamic> body = {
        "name": "string",
        "email": "string",
        "phone": "string",
        "profession": "string",
        "message": "string",
        "url": "string",
        "type": 0
      };
      final response = await api.post(ApiUrl.query, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse> uploadDoc(
      {required String docType, required String url, required int cid}) async {
    try {
      final String? token = await LocaldbHelper.getToken();
      Map<String, dynamic> body = {
        "doctype": docType,
        "url": url,
        "cid": int.parse(token!)
      };
      final response = await api.post(ApiUrl.docUpload, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }
}

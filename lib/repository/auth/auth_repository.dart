import 'package:sterling/models/auth/work_experience.dart';

import '../APIBase/api_response.dart';

abstract class AuthRepository {
  /// A class that helps with Authentication .

  Future userRegistration(Map<String, dynamic> data);
  Future userPersonalDetails(
      {required String address,
      required String gender,
      required String dob,
      required String conuntry,
      required String mobile});

  ///function to add work experience in
  Future addWorkExperience({required List<WorkExperienceModel> list});

  ///to update customer banking details that accept
  ///  [ "nin": "string", nin-> national inssurance number
  ///  "name": "string",
  ///  "bankCode": "string",
  ///  "acNo": "string"

  Future updateBankDetails({
    required String nin,
    required String bankCode,
    required String name,
    required String accNo,
  });

  // "kinName": "string",
  // "kinPhone": "string",
  // "relation": "string",
  Future postKin({
    required String kinNmae,
    required String kinPhone,
    required String relation,
  });

  Future posIdBadge({required String photo});

  Future addReference({
    required String employer,
    required String orginisation,
    required String startDate,
    required String endDate,
  });

  Future backgroundChecks(
      {required String accountName, required String doc, required String date});
  Future postNmc({
    required String date,
    required String nmcPin,
    required String nurseType,
  });

  Future<APIResponse> postEmployerQuery({
    required String name,
    required String email,
    required String phone,
    required String profession,
    required String message,
    required String urls,
    required int type,
  });

  Future<APIResponse> uploadDoc(
      {required String docType, required String url, required int cid});
}

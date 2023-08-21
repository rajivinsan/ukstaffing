import 'package:sterling/models/shifts/shifts_details_model.dart';
import 'package:sterling/models/timesheetmodel.dart';
import 'package:sterling/repository/APIBase/api_response.dart';
import 'package:sterling/models/shifts/shifts_model.dart';
import 'package:sterling/repository/APIBase/api_url.dart';
import 'package:sterling/repository/shifts/shifts_repository.dart';
import 'package:sterling/services/local_db_helper.dart';

import '../APIBase/apiFunction.dart';

class ShiftRepoImpl implements ShiftRepository {
  final ApiFunction api;
  ShiftRepoImpl({required this.api});
  @override
  Future<APIResponse<List<ShiftsListongModel>>> getAllAvailableShift() {
    // TODO: implement getAllAvailableShift
    throw UnimplementedError();
  }

  @override
  Future<APIResponse<List<ShiftsListongModel>>> getAllLocationShift(
      {required int type}) async {
    List<ShiftsListongModel> list = [];
    try {
      final cid = await LocaldbHelper.getToken();

      final response = await api.get(
        "${ApiUrl.shiftLoc}${int.parse(cid.toString())}/${type.toString()}",
        headers: {},
        query: {},
      );
      if (response.success) {
        if (response.data.isNotEmpty) {
          for (int i = 0; i < response.data.length; i++) {
            final data = ShiftsListongModel.fromJson(response.data[i]);
            list.add(data);
          }
        }
        return APIResponse(
            success: true, message: response.message, data: list);
      } else {
        return APIResponse(success: false, message: "e".toString());
      }
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse<List<ShiftsListongModel>>> getShiftInvitation() {
    // TODO: implement getShiftInvitation
    throw UnimplementedError();
  }

  @override
  Future<APIResponse<List<ShiftsListongModel>>> getUpcomingShifts() async {
    List<ShiftsListongModel> list = [];
    try {
      final cid = await LocaldbHelper.getToken();

      final response = await api.get(
          "${ApiUrl.upcommingShift}${int.parse(cid!)}",
          headers: {},
          query: {});
      if (response.success) {
        if (response.data.isNotEmpty) {
          for (int i = 0; i < response.data.length; i++) {
            final data = ShiftsListongModel.fromJson(response.data[i]);
            list.add(data);
            //print(data);
          }
        }
        return APIResponse(
            success: true, message: response.message, data: list);
      } else {
        return APIResponse(success: false, message: "e".toString());
      }
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse<List<ShiftsListongModel>>> getUserBookedShift() async {
    List<ShiftsListongModel> list = [];
    try {
      final cid = await LocaldbHelper.getToken();

      final response = await api.get(
          "${ApiUrl.shiftBook}${int.parse(cid.toString())}",
          headers: {},
          query: {});
      if (response.success) {
        if (response.data.isNotEmpty) {
          for (int i = 0; i < response.data.length; i++) {
            final data = ShiftsListongModel.fromJson(response.data[i]);
            list.add(data);
          }
        }
        return APIResponse(
            success: true, message: response.message, data: list);
      } else {
        return APIResponse(success: false, message: "e".toString());
      }
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse> applyToShift({required int shiftId}) async {
    final cid = await LocaldbHelper.getToken();
    try {
      Map<String, dynamic> body = {"shiftId": shiftId, "cid": int.parse(cid!)};
      final response = await api.post(ApiUrl.shiftBook, body: body);
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  Future<APIResponse> shiftStatus({required int shiftId}) async {
    try {
      final response =
          await api.put("${ApiUrl.shiftBook}$shiftId", body: {}, headers: {});
      return response;
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<APIResponse<ShiftDetailModel>> getShiftDetail(
      {required int id}) async {
    try {
      final response = await api
          .get("${ApiUrl.shiftDetailUsingID}$id", headers: {}, query: {});

      if (response.success) {
        final data = ShiftDetailModel.fromJson(response.data.first);
        return APIResponse(
            success: response.success, message: response.message, data: data);
      } else {
        return APIResponse(
            success: response.success, message: response.message, data: null);
      }
    } catch (e) {
      return APIResponse(success: false, message: e.toString(), data: null);
    }
  }

//Time Sheet
  Future<APIResponse<List<TimeSheet>>> getTimeSheetDetail(
      {required int id}) async {
    List<TimeSheet> list = [];
    try {
      final response =
          await api.get("${ApiUrl.timeSheetDetail}$id", headers: {}, query: {});

      if (response.success) {
        if (response.data.isNotEmpty) {
          for (int i = 0; i < response.data.length; i++) {
            final data = TimeSheet.fromJson(response.data[i]);
            list.add(data);
          }
        }
        return APIResponse(
            success: response.success, message: response.message, data: list);
      } else {
        return APIResponse(
            success: response.success, message: response.message, data: null);
      }
    } catch (e) {
      return APIResponse(success: false, message: e.toString(), data: null);
    }
  }
}

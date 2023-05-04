import 'package:sterling/models/shifts/shifts_details_model.dart';
import 'package:sterling/models/shifts/shifts_model.dart';
import 'package:sterling/repository/APIBase/api_response.dart';

abstract class ShiftRepository {
  Future<APIResponse<List<ShiftsListongModel>>> getUpcomingShifts();
  Future<APIResponse<List<ShiftsListongModel>>> getShiftInvitation();

  Future<APIResponse<List<ShiftsListongModel>>> getUserBookedShift();
  Future<APIResponse<List<ShiftsListongModel>>> getAllAvailableShift();
  Future<APIResponse<List<ShiftsListongModel>>> getAllLocationShift(
      {required int type});

  Future applyToShift({required int shiftId});

  Future<APIResponse<ShiftDetailModel>> getShiftDetail({required int id});
}

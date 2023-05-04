import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/provider/repository_provider.dart';

import '../models/shifts/shifts_details_model.dart';

final shiftDetailsProvider = FutureProvider.family
    .autoDispose<ShiftDetailModel?, int>((ref, shiftId) async {
  final response =
      await ref.read(shiftRepositoryProvider).getShiftDetail(id: shiftId);
  return response.data;
});

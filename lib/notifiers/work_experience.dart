import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/models/auth/work_experience.dart';

class WorkExperienceProvider extends StateNotifier<List<WorkExperienceModel>> {
  WorkExperienceProvider(super.state);

  void addWork(
      {required String employerName,
      required String startDate,
      int? cid,
      String? endDate}) {
    state = [
      ...state,
      WorkExperienceModel(
          employerName: employerName,
          startDate: startDate,
          endDate: endDate,
          cid: cid)
    ];
  }

  void removeWork(WorkExperienceModel target) {
    state = state
        .where((todo) => todo.employerName != target.employerName)
        .toList();
  }
}

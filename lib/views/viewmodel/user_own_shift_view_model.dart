import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/services/local_db_helper.dart';
import 'package:sterling/views/viewmodel/home/home_state.dart';

import '../../../constants/enum.dart';
import '../../../provider/repository_provider.dart';

final userOwnShiftProvider =
    StateNotifierProvider<UserOwnShiftViewModel, HomeState>((ref) {
  return UserOwnShiftViewModel(ref)..userBookingShift();
});

final userTimeSheetProvider =
    StateNotifierProvider<UserOwnShiftViewModel, HomeState>((ref) {
  return UserOwnShiftViewModel(ref)..userTimeSheet();
});

class UserOwnShiftViewModel extends StateNotifier<HomeState> {
  UserOwnShiftViewModel(this.ref) : super(const HomeState());
  final Ref ref;

  Future<void> userBookingShift({bool isInitial = true}) async {
    if (state.status == Status.loadMore) return;
    try {
      if (isInitial) {
        state = state.copWith(
          offset: 0,
          status: Status.loading,
        );
      } else {
        state = state.copWith(
          offset: 0,
          status: Status.loadMore,
        );
      }

      final response =
          await ref.read(shiftRepositoryProvider).getUserBookedShift();
      if (response.success) {
        state = state.copWith(
          status: Status.success,
          data: response.data,
        );
      } else {
        state = state.copWith(
          status: Status.error,
          data: null,
          errorMessage: response.message,
        );
      }
    } catch (e) {
      state = state.copWith(
        status: isInitial ? Status.error : Status.loadMoreError,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> userTimeSheet({bool isInitial = true}) async {
    if (state.status == Status.loadMore) return;
    try {
      if (isInitial) {
        state = state.copWith(
          offset: 0,
          status: Status.loading,
        );
      } else {
        state = state.copWith(
          offset: 0,
          status: Status.loadMore,
        );
      }
      final cid = await LocaldbHelper.getToken();

      final response = await ref
          .read(shiftRepositoryProvider)
          .getTimeSheetDetail(id: int.parse(cid!));
      if (response.success) {
        state = state.copWith(
          status: Status.success,
          data: response.data,
        );
      } else {
        state = state.copWith(
          status: Status.error,
          data: null,
          errorMessage: response.message,
        );
      }
    } catch (e) {
      state = state.copWith(
        status: isInitial ? Status.error : Status.loadMoreError,
        errorMessage: e.toString(),
      );
    }
  }
}

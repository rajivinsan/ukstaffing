import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/views/viewmodel/home/home_state.dart';

import '../../../constants/enum.dart';
import '../../../provider/repository_provider.dart';

final homeviewProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(ref)..getUpcommingSHift();
});

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this.ref) : super(const HomeState());
  final Ref ref;

  Future<void> getUpcommingSHift({bool isInitial = true}) async {
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
          await ref.read(shiftRepositoryProvider).getUpcomingShifts();
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

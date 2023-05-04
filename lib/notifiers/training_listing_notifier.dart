import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/services/local_db_helper.dart';
import 'package:sterling/views/auth/professionDetail/training/training_page.dart';

class TrainingListingNotifier extends StateNotifier<List<CertificateModel>> {
  TrainingListingNotifier(super.state);

  load() async {
    final data = await LocaldbHelper.getTraingLisitingDetails();

    state = data;
  }

  updateProfessionList(int id) {
    state = [
      for (final todo in state)
        // we're marking only the matching todo as completed
        if (todo.id == id)
          // Once more, since our state is immutable, we need to make a copy
          // of the todo. We're using our `copyWith` method implemented before
          // to help with that.
          todo.copWith(isCompelete: true)
        else
          // other todos are not modified
          todo,
    ];
    print(state);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/models/auth/detail_listing_model.dart';
import 'package:sterling/services/local_db_helper.dart';

class ProfessionalListingNotifier
    extends StateNotifier<List<ProfessionDetailsModel>> {
  ProfessionalListingNotifier(super.state);

  load() async {
    final data = await LocaldbHelper.getLisitingDetails();

    state = data;
  }

  updateProfessionList(int id) async {
    try {
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
    } catch (error) {
      print(error.toString());
    }
   // print(state);
  }
}

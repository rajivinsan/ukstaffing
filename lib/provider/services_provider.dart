import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/models/auth/detail_listing_model.dart';
import 'package:sterling/notifiers/professional_listing_notifier.dart';
import 'package:sterling/notifiers/training_listing_notifier.dart';
import 'package:sterling/views/auth/professionDetail/training/training_page.dart';

import '../models/auth/work_experience.dart';
import '../notifiers/bootom_bar_provider.dart';
import '../notifiers/work_experience.dart';
import '../repository/APIBase/apiFunction.dart';

final dioServiceProvider = Provider<ApiFunction>((ref) => ApiFunction(ref));

final bottomBarProvider = StateNotifierProvider((ref) => BottomBarProvider());
final workListProvider =
    StateNotifierProvider<WorkExperienceProvider, List<WorkExperienceModel>>(
        (ref) {
  return WorkExperienceProvider([]);
});
final listingProvider = StateNotifierProvider<ProfessionalListingNotifier,
    List<ProfessionDetailsModel>>((ref) {
  return ProfessionalListingNotifier([])..load();
});
final trainingListingProvider =
    StateNotifierProvider<TrainingListingNotifier, List<CertificateModel>>(
        (ref) {
  return TrainingListingNotifier([])..load();
});

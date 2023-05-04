import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/repository/auth/auth_repository_impl.dart';
import 'package:sterling/repository/shifts/shift_repository_impl.dart';

import 'services_provider.dart';

final authRepositoryProvider = Provider<AuthRepositoryImpl>(
  (ref) => AuthRepositoryImpl(
    api: ref.read(dioServiceProvider),
  ),
);

final shiftRepositoryProvider = Provider<ShiftRepoImpl>(
  (ref) => ShiftRepoImpl(
    api: ref.read(dioServiceProvider),
  ),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBarProvider extends StateNotifier<int> {
  BottomBarProvider() : super(0);

  chnageIndex(int i) {
    state = i;
  }
}

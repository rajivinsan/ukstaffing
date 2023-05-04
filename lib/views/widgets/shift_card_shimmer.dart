import 'package:flutter/material.dart';
import 'package:sterling/utilities/ui/shimmer_effects.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/utilities/ui/utility.dart';
import 'package:sterling/views/widgets/shadow_container.dart';
import 'package:sterling/views/widgets/shift_shimmer.dart';

import '../../constants/text_style.dart';

class ShiftCardShimmer extends StatelessWidget {
  const ShiftCardShimmer({super.key, required this.length});
  final int length;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: length,
        itemBuilder: (context, index) {
          return const ShiftShimmer();
        });
  }
}

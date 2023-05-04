import 'package:flutter/material.dart';
import 'package:sterling/views/widgets/shadow_container.dart';

import '../../constants/text_style.dart';
import '../../utilities/ui/shimmer_effects.dart';
import '../../utilities/ui/size_config.dart';
import '../../utilities/ui/utility.dart';

class ShiftShimmer extends StatelessWidget {
  const ShiftShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ShadowContainer(
        height: height! * 0.23,
        radius: 21,
        color: Colors.white,
        borderColor: const Color.fromRGBO(0, 0, 0, 0.1),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Utility.hSize(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        Utility.vSize(10),
                        Container(
                          width: 50,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        Utility.vSize(10),
                        Container(
                          width: 80,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                size20,
                Container(
                  color: Colors.black,
                  height: 1,
                ),
                size20,
                size20,
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      height: 20,
                      width: 20,
                    ),
                    Utility.hSize(5),
                    _buildContainer(height: 10, width: 60),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      height: 20,
                      width: 20,
                    ),
                    Utility.hSize(5),
                    _buildContainer(height: 10, width: 60),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      height: 20,
                      width: 20,
                    ),
                    Utility.hSize(
                      5,
                    ),
                    _buildContainer(height: 10, width: 60)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildContainer({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/widgets/contimue_button.dart';

class SteppereBottomControl extends StatelessWidget {
  SteppereBottomControl(
      {super.key,
      required this.backFunction,
      required this.continueFunction,
      required this.isShowBack});
  final bool isShowBack;
  void Function()? backFunction;
  void Function()? continueFunction;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight!;
    var width = SizeConfig.screenWidth!;
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            isShowBack
                ? const SizedBox.shrink()
                : InkWell(
                    onTap: backFunction,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromRGBO(255, 175, 175, 1)),
                      child: Text("Back",
                          style: codeProHeadStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          )),
                    ),
                  ),
            const SizedBox(
              width: 20,
            ),
            Expanded(child: ContinueBotton(onTap: continueFunction)),
          ],
        ),
      ),
    );
  }
}

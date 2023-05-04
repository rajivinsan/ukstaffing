import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/size_config.dart';

class BottomButton extends StatelessWidget {
  BottomButton(
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
            !isShowBack
                ? const SizedBox.shrink()
                : InkWell(
                    onTap: backFunction,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kPrimaryColor.withOpacity(0.1),
                      ),
                      child: Text("Back",
                          style: codeProHeadStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            fontSize: 14,
                          )),
                    ),
                  ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: InkWell(
                onTap: continueFunction,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kPrimaryColor,
                  ),
                  child: Text(
                    "Continue".capitalize(),
                    textAlign: TextAlign.center,
                    style: codeProHeadStyle.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

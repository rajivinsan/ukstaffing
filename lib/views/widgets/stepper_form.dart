import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';

class CommonStepperForm extends StatefulWidget {
  CommonStepperForm({
    Key? key,
    required this.steps,
    required this.onStepCancel,
    required this.onStepContinue,
    required this.onStepTapped,
    required this.activeStepIndex,
  }) : super(key: key);
  List<Step> steps;
  Function()? onStepContinue;
  Function()? onStepCancel;
  void Function(int)? onStepTapped;

  int activeStepIndex;
  @override
  State<CommonStepperForm> createState() => _CommonStepperFormState();
}

class _CommonStepperFormState extends State<CommonStepperForm> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.light(primary: kPrimaryColor),
      ),
      child: Stepper(
        physics: const ClampingScrollPhysics(),
        elevation: 0,
        type: StepperType.horizontal,
        currentStep: widget.activeStepIndex,
        steps: widget.steps,
        onStepContinue: () {
          // if (_activeStepIndex < (stepList().length - 1)) {
          //   setState(() {
          //     _activeStepIndex += 1;
          //   });
          // } else {
          //   print('Submited');
          // }
        },
        onStepCancel: () {
          // if (_activeStepIndex == 0) {
          //   return;
          // }

          setState(() {
            //   _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            //_activeStepIndex = index;
          });
        },
        controlsBuilder: (context, details) {
          final isLastStep = widget.activeStepIndex == widget.steps.length - 1;
          return Container();
        },
      ),
    );
  }
}

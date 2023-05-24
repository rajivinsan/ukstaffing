import 'package:flutter/cupertino.dart';
import 'package:sterling/constants/text_style.dart';

class UnsubmittedPage extends StatefulWidget {
  const UnsubmittedPage({super.key});

  @override
  State<UnsubmittedPage> createState() => _UnsubmittedPageState();
}

class _UnsubmittedPageState extends State<UnsubmittedPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/shift_calender.png"),
            size20,
            Center(
              child: Text(
                'Here you will find all the unsubmited shift',
                style: redHatMedium.copyWith(
                  color: const Color(
                    0xff666666,
                  ),
                  fontSize: 20,
                ),
              ),
            ),
            size10,
            // Text(
            //   "Apply for shifts now and come back to this screen once you've worked them.",
            //   style: redHatbold.copyWith(
            //     color: const Color(
            //       0xff666666,
            //     ),
            //     fontSize: 20,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

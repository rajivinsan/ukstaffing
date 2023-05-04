import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/ui/utility.dart';
import 'package:sterling/views/onboarding/on_boarding_model.dart';
import 'package:sterling/views/onboarding/professional_selector_screens.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SliderView());
  }
}

class SliderView extends StatefulWidget {
  const SliderView({Key? key}) : super(key: key);

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    // Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    //   if (_currentPage < 1) {
    //     _currentPage++;
    //   } else {
    //     _currentPage = 0;
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                text: "1",
                style: sourceCodeProStyle.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: "/",
                style: sourceCodeProStyle.copyWith(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: "3",
                style: sourceCodeProStyle.copyWith(
                  color: _currentPage == 2
                      ? Colors.black
                      : Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ])),
            const Spacer(),
            Text(
              "Skip",
              style: sourceCodeProStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        leadingWidth: 100,
      ),
      body: Stack(
        // alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: sliderArrayList.length,
              itemBuilder: (ctx, i) => SlideItem(i),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.elasticInOut);
                if (_currentPage == 2) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectProfessionScreen()),
                      (route) => false);
                }
              },
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    color: kPrimaryColor,
                    border: Border.all(color: Colors.black, width: 1.4)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: sourceCodeProStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Utility.hSize(5),
                    Builder(builder: (context) {
                      if (_currentPage == 0) {
                        return SvgPicture.asset(
                          SvgAsset.forward1,
                          height: 12,
                          color: Colors.white,
                        );
                      } else if (_currentPage == 1) {
                        return Row(
                          children: [
                            SvgPicture.asset(
                              SvgAsset.forward1,
                              height: 12,
                              color: Colors.white.withOpacity(0.44),
                            ),
                            SvgPicture.asset(
                              SvgAsset.forward1,
                              height: 12,
                              color: Colors.white,
                            ),
                          ],
                        );
                      } else {
                        return Row(
                          children: [
                            SvgPicture.asset(
                              SvgAsset.forward1,
                              height: 12,
                              color: Colors.white.withOpacity(0.44),
                            ),
                            SvgPicture.asset(
                              SvgAsset.forward1,
                              height: 12,
                              color: Colors.white.withOpacity(0.44),
                            ),
                            SvgPicture.asset(
                              SvgAsset.forward1,
                              height: 12,
                              color: Colors.white,
                            ),
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: MediaQuery.of(context).size.width * 1.1,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          alignment: Alignment.center,
          // width: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(
                    0,
                    4,
                  ),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.25))
            ],
            color: kPrimaryColor,
          ),
          child: Image.asset(
            sliderArrayList[index].sliderImageUrl,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(sliderArrayList[index].sliderHeading,
            style: sourceCodeProStyle.copyWith(
                color: darkTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        // Center(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 40.0),
        //     child: Text(
        //       sliderArrayList[index].sliderSubHeading,
        //       style: sourceCodeProStyle.copyWith(
        //         color: lightTextColor,
        //         fontWeight: FontWeight.w700,
        //         fontSize: 16,
        //       ),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // )
      ],
    );
  }
}

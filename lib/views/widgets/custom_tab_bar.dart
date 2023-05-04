import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/ui/size_config.dart';

// ignore: must_be_immutable
class CustomTabBarView extends StatelessWidget {
  CustomTabBarView(
      {Key? key,
      required this.length,
      required this.widget,
      required this.tabController,
      required this.appBarName,
      required this.tabWidget,
      required this.onTap})
      : super(key: key);
  int length;
  List<Widget> widget;
  final String appBarName;
  List<Widget> tabWidget;
  TabController? tabController;
  void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight!;
    return DefaultTabController(
      length: length,
      child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: Text(
              appBarName,
              style: codeProHeadStyle.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            backgroundColor: const Color(0xffF3F3F3),
            elevation: 1,
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: TabBar(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
                  onTap: onTap,
                  isScrollable: true,
                  controller: tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      22,
                    ),
                    color: kPrimaryColor,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),

                  labelColor: Colors.white,
                  labelStyle: redHatMedium.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  unselectedLabelStyle: redHatMedium.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      const Shadow(
                        blurRadius: 4.0,
                        color: Color.fromRGBO(
                          0,
                          0,
                          0,
                          0.1,
                        ),
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  unselectedLabelColor: kPrimaryColor,
                  // ignore: prefer_const_literals_to_create_immutables
                  tabs: widget,
                ),
              ),
              size20,
              Expanded(
                  child: TabBarView(
                      controller: tabController, children: tabWidget)),
            ],
          )),
    );
  }
}

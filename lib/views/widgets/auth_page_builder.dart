import 'package:flutter/material.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/widgets/page_view_indicator.dart';

class AuthPageBuilder extends StatefulWidget {
  AuthPageBuilder({
    Key? key,
    required this.widgets,
    this.controller,
    this.initialPage,
    this.appBar,
    required this.onPageChanged,
  }) : super(key: key);
  final List<Widget> widgets;
  AppBar? appBar;
  PageController? controller;

  Function(int)? onPageChanged;

  int? initialPage;
  @override
  State<AuthPageBuilder> createState() => _AuthPageBuilderState();
}

class _AuthPageBuilderState extends State<AuthPageBuilder> {
  //int initialPage = 0;
  // final PageController controller = PageController(initialPage: 0);
  // List<Widget> widgets = [const NumberShiftsScreen(), const PostalCodeScreen()];

  _onPageChanged(int index) {
    setState(() {
      widget.initialPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        //alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: PageView.builder(
              //  physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: widget.controller,
              onPageChanged: widget.onPageChanged,
              itemCount: widget.widgets.length,
              itemBuilder: (ctx, index) {
                return SingleChildScrollView(
                  child: widget.widgets[index],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.widgets.length; i++)
                Indicator(
                  currentIndex: i,
                  isActivate: i == widget.initialPage,
                  totalPage: widget.widgets.length,
                )
            ],
          ),
        ],
      ),
    );
  }
}

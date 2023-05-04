import 'package:flutter/material.dart';
import 'package:sterling/utilities/ui/size_config.dart';

class AppBarCard extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCard({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: SizeConfig.screenHeight! * 0.20,
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 15,
              spreadRadius: 0,
              color: Colors.white.withOpacity(0.1)),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: child,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

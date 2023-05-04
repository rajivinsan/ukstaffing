library edge_alert;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EdgeAlert {
  static const int LENGTH_SHORT = 1; //1 seconds
  static const int LENGTH_LONG = 2; // 2 seconds
  static const int LENGTH_VERY_LONG = 3; // 3 seconds

  static const int TOP = 1;
  static const int BOTTOM = 2;

  static void show(
    BuildContext context, {
    String description='',
    int ?duration,
    int ?gravity,
    Color? backgroundColor,
  }) {
    OverlayView.createView(
      context,
      description: description,
      duration: duration,
      gravity: gravity,
      backgroundColor: backgroundColor,
    );
  }
}

class OverlayView {
  static OverlayView ?_singleton;

  factory OverlayView() {
    _singleton ??= OverlayView._private();
    return _singleton!;
  }

  OverlayView._private();

  static OverlayState ?_overlayState;
  static OverlayEntry ?_overlayEntry;
  static bool _isVisible = false;

  static void createView(
    BuildContext context, {
    String description = '',
    int ?duration,
    int ?gravity,
    Color ?backgroundColor,
  }) {
    _overlayState = Navigator.of(context).overlay;
    if (!_isVisible) {
      _isVisible = true;
      _overlayEntry = OverlayEntry(builder: (context) {
        return EdgeOverlay(
          description: description,
          overlayDuration: duration == null ? EdgeAlert.LENGTH_SHORT : duration,
          gravity: gravity == null ? EdgeAlert.TOP : gravity,
          backgroundColor:
              backgroundColor == null ? Colors.grey : backgroundColor,
        );
      });

      _overlayState!.insert(_overlayEntry!);
    }
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class EdgeOverlay extends StatefulWidget {
  final String description;
  final int overlayDuration;
  final int gravity;
  final Color backgroundColor;

  EdgeOverlay({
    required this.description,
    required this.overlayDuration,
    required this.gravity,
    required this.backgroundColor,
  });

  @override
  _EdgeOverlayState createState() => _EdgeOverlayState();
}

class _EdgeOverlayState extends State<EdgeOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<Offset> _positionTween;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));

    if (widget.gravity == 1) {
      _positionTween =
          Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero);
    } else {
      _positionTween =
          Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0));
    }

    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();

    listenToAnimation();
  }

  listenToAnimation() async {
    _controller.addStatusListener((listener) async {
      if (listener == AnimationStatus.completed) {
        await Future.delayed(Duration(seconds: widget.overlayDuration));
        _controller.reverse();
        await Future.delayed(Duration(milliseconds: 700));
        OverlayView.dismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomHeight = MediaQuery.of(context).padding.bottom;

    return Positioned(
      top: widget.gravity == 1 ? 0 : null,
      bottom: widget.gravity == 2 ? 0 : null,
      child: SlideTransition(
        position: _positionAnimation,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
              20,
              widget.gravity == 1 ? statusBarHeight + 20 : bottomHeight + 20,
              20,
              widget.gravity == 1 ? 20 : 35),
          color: widget.backgroundColor,
          child: OverlayWidget(
            description: widget.description,
          ),
        ),
      ),
    );
  }
}

class OverlayWidget extends StatelessWidget {
  final String description;

  const OverlayWidget({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Text(
        description,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

class AnimatedIcon extends StatefulWidget {
  final IconData iconData;

  AnimatedIcon({required this.iconData});

  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.8,
        upperBound: 1.1,
        duration: Duration(milliseconds: 600));

    _controller.forward();
    listenToAnimation();
  }

  listenToAnimation() async {
    _controller.addStatusListener((listener) async {
      if (listener == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (listener == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: _controller,
        child: Icon(
          widget.iconData,
          size: 35,
          color: Colors.white,
        ),
        builder: (context, widget) =>
            Transform.scale(scale: _controller.value, child: widget),
      ),
    );
  }
}

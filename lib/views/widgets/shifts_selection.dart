import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';

class ShiftSelectionTile extends StatefulWidget {
  ShiftSelectionTile(
      {Key? key, required this.data, required this.selectedShift})
      : super(key: key);
  final List<ShiftSelectionModel> data;
  int selectedShift;
  @override
  State<ShiftSelectionTile> createState() => _ShiftSelectionTileState();
}

class _ShiftSelectionTileState extends State<ShiftSelectionTile> {
  int index = -1;
  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8,
        runSpacing: 20,
        children: widget.data
            .map(
              (e) => InkWell(
                onTap: () {
                  onTap(e.value);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: e.value == widget.selectedShift
                        ? kPrimaryColor
                        : kCardColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 22,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ],
                        ),
                        child: Text(
                          e.value.toString(),
                          style: sourceCodeProStyle.copyWith(
                            fontSize: 90,
                            fontWeight: FontWeight.w600,
                            shadows: textShadow,
                          ),
                        ),
                      ),
                      if (e.value == widget.selectedShift)
                        Container(
                          margin: const EdgeInsets.all(6),
                          padding: const EdgeInsets.all(0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(5, 237, 70, 0.77)),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
            .toList());
  }

  int onTap(int value) {
    setState(() {
      widget.selectedShift = value;
    });
    return index;
  }
}

class ShiftSelectionModel {
  int value;
  bool? isSelected;
  ShiftSelectionModel({this.isSelected, required this.value});
}

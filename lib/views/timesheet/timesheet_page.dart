import 'package:flutter/material.dart';

import '../widgets/timesheet/timesheet_card.dart';

class TimeSheetPage extends StatefulWidget {
  const TimeSheetPage({super.key});

  @override
  State<TimeSheetPage> createState() => _TimeSheetPageState();
}

class _TimeSheetPageState extends State<TimeSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 10), child: TimeSheetCard()),
      ),
    );
  }
}

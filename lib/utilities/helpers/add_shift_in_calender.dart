import 'package:add_2_calendar/add_2_calendar.dart';

class AddShiftInCalender {
  static addInCalender({
    Recurrence? recurrence,
    required String? title,
    required String? description,
    required String? location,
    required DateTime? startDate,
    required DateTime? endDate,
  }) {
    final Event event = Event(
        title: title ?? 'Event title',
        description: description ?? 'Event description',
        startDate: startDate ?? DateTime.now(),
        endDate: endDate ?? DateTime.now());

    Add2Calendar.addEvent2Cal(event);
  }
}

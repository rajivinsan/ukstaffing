import 'package:intl/intl.dart';

class DateTimeHelpers {
  static String formatDate(String date) {
    var utc = DateTime.parse(date);

    /// convert [utc] into [local] datetime
    var stri = utc.toLocal().toString();

    var newSt = '${stri.substring(0, 10)} ${stri.substring(11, 23)}';

    ///format date time according to requirement
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(newSt);
    var outputFormat = DateFormat('MM.dd.yy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }
}

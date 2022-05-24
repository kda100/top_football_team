import 'package:intl/intl.dart';
import 'package:clock/clock.dart';

///helper class to add additional function to date time object.

class DateTimeHelper {
  ///returns a DateTime object based on the current day Date(2022, 5, 23)
  static DateTime today() {
    DateTime now = clock.now();
    return DateTime(now.year, now.month, now.day);
  }

  ///converts DateTime object to "2022-05-24" format.
  static dateTimeToString(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat("yyyy-MM-dd").format(dateTime);
    }
    return "";
  }
}

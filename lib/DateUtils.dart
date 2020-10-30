import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtils {
  static DateTime getTodayDateTime() {
    return DateTime.now();
  }

  static String getDateTimeFromDayOfYear(String givenDayOfYear) {
    //  new DateTime.utc(1969, 7, 20, 20, 18, 04);
    // (year, month, day, hour, minute, second, millisecond, microsecond);
    DateTime date = new DateTime(getTodayDateTime().year, 1,
        int.parse(givenDayOfYear), 12, 30, 40, 100, 100);
    return date.toString().substring(0, 10);
  }

  static String getDayOfYearFromDateTime(DateTime selectedDateTime) {
    String dayOfYear = DateFormat("D").format(selectedDateTime).toString();

    if (dayOfYear.length == 2) {
      dayOfYear = "0" + dayOfYear;
    }
    if (dayOfYear.length == 1) {
      dayOfYear = "00" + dayOfYear;
    }
    return dayOfYear;
  }

  static Future<DateTime> getDatePickerDialog(BuildContext buildContext) {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: buildContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }
}

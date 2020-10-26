import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtils {
  String getFormattedTodayDate() {
    String today = DateTime.now().toString().substring(0, 10);
    debugPrint("**** getFormattedTodayDate : " + today);
    return today;
  }

  static DateTime getTodayDateTime() {
    return DateTime.now();
  }

  static String getDayOfYearFromDateTime(DateTime selectedDateTime) {
    String dayOfYear = DateFormat("D").format(selectedDateTime).toString();
    debugPrint("**** getDayOfYearFromDateTime : " +
        selectedDateTime.toString() +
        " -> " +
        dayOfYear);
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

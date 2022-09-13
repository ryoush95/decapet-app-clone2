// date formate
import 'package:decapet/language/language_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String convertDateFromStr(String input, String inFormat, String outFormat) {
  DateFormat inDateFormat = DateFormat(inFormat);
  DateFormat outDateFormat = DateFormat(outFormat);

  DateTime dateTime = inDateFormat.parse(input);
  String output = outDateFormat.format(dateTime);
  return output;
}

String getCurrentDate() {
  initializeDateFormatting();
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  return formattedDate;
}

String getDateFormatString(DateTime date, String format) {
  initializeDateFormatting();
  return DateFormat(format, "ko").format(date);
}

String getDateFormatString1(DateTime date) {
  return date.year.toString() + LanguageService.trans("year") + " " + date.month.toString() + LanguageService.trans("month") + " " + date.day.toString() + LanguageService.trans("day1");
}

int getDayDiff(String date) {
  DateTime now = DateTime.now();
  DateTime current = DateTime.parse(date);
  Duration duration = current.difference(now);
  return duration.inDays;
}

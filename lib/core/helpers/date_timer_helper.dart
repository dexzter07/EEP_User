import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTimeHelper? _instance;

  DateTimeHelper._();

  factory DateTimeHelper() {
    _instance ??= DateTimeHelper._();
    return _instance!;
  }

  String getCurrentDateAndTime() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return dateFormat.format(DateTime.now());
  }
}

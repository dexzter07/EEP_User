import 'package:intl/intl.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/23/2023, Thursday

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

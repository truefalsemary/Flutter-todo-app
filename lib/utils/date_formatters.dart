import 'package:intl/intl.dart';

class DateFormatters {
  static String? formatDate(DateTime? dateTime, [String? locale]) {
    if (dateTime != null) {
      return DateFormat('dd MMMM yyyy', locale).format(dateTime);
    }
    return null;
  }
}

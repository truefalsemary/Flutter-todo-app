import 'package:intl/intl.dart';

class DateFormatters {
  static String? formatDate(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat('dd MMMM yyyy').format(dateTime);
    }
    return null;
  }
}

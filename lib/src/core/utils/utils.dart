import 'package:intl/intl.dart';

class Utils {
  static String changeDate(String date) {
    String dateNew = DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
    return dateNew;
  }
}

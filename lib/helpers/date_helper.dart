import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static DateFormat _format = DateFormat('dd/MM/yyyy');

  static DateTime parse(String date) {
    if (date == null) return null;
    if (date.isEmpty) return null;
    if (date.length < 10) return null;
    return _format.parse(date);
  }

  static String format(DateTime date) {
    if (date == null) return '';
    return _format.format(date);
  }

  static String relative(String date) {
    final dueDate = parse(date);
    final today = DateTime.now();
    final diff = today.difference(dueDate);

    if (diff.inDays < 1) return 'Hoje';
    if (diff.inDays < 30) return '${diff.inDays}d';
    if (diff.inDays > 1000) return 'perdeu playboy!';
    if (diff.inDays > 365) return format(dueDate);

    final month = DateFormat.MMM().format(dueDate).substring(0, 3);
    return '${dueDate.day} $month';
  }
}

import 'package:intl/intl.dart';

String formatDateIntToString(String date) {
  final DateTime parsedDate = DateTime.parse(date);
  final DateFormat formatter = DateFormat('d MMMM, yyyy', 'en_US');
  return formatter.format(parsedDate);
}
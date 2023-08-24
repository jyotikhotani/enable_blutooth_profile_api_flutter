import 'package:intl/intl.dart';

class CommonMethods {
  static String differenceinDays(String dateStr) {
    String dateString = "2022-04-30T05:26:07.516Z";
    DateTime targetDate = DateTime.parse(dateStr);
    DateTime currentDate = DateTime.now();

    int differenceInDays = currentDate.difference(targetDate).inDays;

    print('Difference indays: $differenceInDays');
    String days = differenceInDays.toString();
    return days;
  }

  static String convertDDMMYY(String dateString) {
//  String dateString = "1989-09-21T20:05:54.159Z";
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yyyy').format(date);
    return formattedDate;
  }
}

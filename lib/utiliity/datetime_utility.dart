import 'package:intl/intl.dart';
  final List<String>   months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ]; 

class DTUtility {
  static String getDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  static String getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  static int calculateDaysCount(DateTime firstDate, DateTime lastDate) {
    return lastDate.difference(firstDate).inDays + 1;
  }

  static String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
  
static int getCurrentDate() {
      DateTime currentDate = DateTime.now();
     int  currentDay = currentDate.day;
      return currentDay ;
    }


}

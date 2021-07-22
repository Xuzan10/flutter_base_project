import 'package:intl/intl.dart';

class DateTimeUtil {
  
  static DateTime? parseDateWithPattern(
      {String? date, String pattern = "yyyy/MM/dd"}) {
    try {
      if (date == null) return null;
      return DateFormat(pattern).parse(date);
    } on FormatException {
      return null;
    }
  }

  static String? dateToString(DateTime dateTime) {
    try {
      return DateFormat.yMMMd().format(dateTime.toLocal());
    } catch (e) {
      return null;
    }
  }

  static int getDaysAgo(DateTime date) {
    return DateTime.now().difference(date).inDays;
  }

  static getFormattedDateFromString(String? date, {String format = "dd MMM"}) {
    if (date != null && date.isNotEmpty)
      return DateFormat(format)
          .format(DateFormat('dd MMM yyyy HH:mm aa').parse(date));
    else
      return "";
  }

  static getFormattedDateFromStringWithInput(String? date,
      {String inputFormat = "dd MMMM yyyy", String outputFormat = "dd MMM"}) {
    if (date != null && date.isNotEmpty)
      return DateFormat(outputFormat)
          .format(DateFormat(inputFormat).parse(date));
    else
      return "";
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);
    return today == dateToCheck;
  }

  static bool isFutureDate(String? date) {
    if (date == null) {
      return false;
    }
    final dateTime = DateFormat("dd MMM yyyy HH:mm aa").parse(date);
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (aDate == tomorrow) return true;
    return false;
  }

  static String formatDate(DateTime date, String format) {
    return DateFormat(format).format(date);
  }

  static String timeAgo(DateTime date) {
    final currentDurationInMilliSeconds = DateTime.now().millisecondsSinceEpoch;
    final durationInMilliseconds = date.millisecondsSinceEpoch;

    int timeDifference =
        (currentDurationInMilliSeconds - durationInMilliseconds) ~/
            (1000 * 60 * 60);

    if (timeDifference < 1000 * 60) {
      return "${timeDifference * 60} minutes ago";
    } else
      return "$timeDifference hours ago";
  }

  static String getDurationFormattedInMinutesSeconds(Duration? duration) {
    if (duration == null) {
      return "";
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

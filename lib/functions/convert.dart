import 'dart:ffi';
import 'dart:math';
// import 'dart:convert';

double getNumsByString(String s) {
  String resStr = '';
  bool dotExists = false;

  for (int i = 0; i < s.length; i++) {
    // Перебираем все символы строки

    String char = s[i].replaceAll(',', '.');
    if ((char == '.') & (!dotExists)) {
      resStr = resStr + char;
      dotExists = true;
    }
    if (char == '-') {
      resStr = (resStr + s[i]);
    }
    num? tmp = num.tryParse(s[i]);
    if (tmp != null) {
      resStr = (resStr + s[i]);
    }
  }

  return (double.tryParse(resStr) ?? 0);
}

extension DateTimeSqlExtension on DateTime {
  String convertToSqlFormat() {
    try {
      return toString().substring(0, 10).replaceAll('-', '');
    } catch (e) {
      return '';
    }
  }

  int get lastDayOfMonth {
    return month < 12
        ? DateTime(year, month + 1, 0).day
        : DateTime(year + 1, 1, 0).day;
  }

  int get daysInMonth {
    return DateTime(year, month + 1, 1)
        .difference(DateTime(year, month, 1))
        .inDays;
  }

  DateTime get getDateOnly {
    return DateTime(year, month, day);
  }

  String addDaysToSqlFormat(int days) {
    try {
      return add(Duration(days: days))
          .toString()
          .substring(0, 10)
          .replaceAll('-', '');
    } catch (e) {
      return '';
    }
  }
}

extension StrDateTimeSqlExtension on String {
  String convertSqlFormatString() {
    try {
      return '${toString().substring(4, 2)}.${toString().substring(2, 2)}.${toString().substring(0, 4)}';
    } catch (e) {
      return 'неизвестная дата';
    }
  }
}

extension ToMilliseconds on num {
  int toMilliseconds() {
    String value = toString();
    try {
      if (value.toString().length == 10) {
        value = ('${value}000');
      }
      return int.parse(value);
    } catch (e) {
      return toInt();
    }
  }
}

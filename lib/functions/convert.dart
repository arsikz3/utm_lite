double getNumsByString(String s) {
  String resStr = '0';
  bool dotExists = false;
  for (int i = 0; i < s.length; i++) {
    // Перебираем все символы строки

    String char = s[i].replaceAll(',', '.');
    if ((char == '.') & (!dotExists)) {
      resStr = resStr + char;
      dotExists = true;
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

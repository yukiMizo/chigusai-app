enum GakusaiDay { taiikusai, bunkasai1, bunkasai2, zenkokikaku }

class Time {
  final int hour;
  final int minute;
  final GakusaiDay day;

  const Time({
    required this.hour,
    required this.day,
    this.minute = 0,
  });

  String _convertMinuteIntToString(int minuteInt) {
    if (minuteInt < 10) {
      return "0$minuteInt";
    } else {
      return minuteInt.toString();
    }
  }

  String _convertHourIntToString(int hourInt) {
    if (hourInt < 10) {
      return "  $hourInt";
    } else {
      return hourInt.toString();
    }
  }

  String getTimeAsString() {
    final String hourString = _convertHourIntToString(hour);
    final String minuteString = _convertMinuteIntToString(minute);

    return "$hourString:$minuteString";
  }

  String getDayAsString() {
    return switch (day) {
      GakusaiDay.taiikusai => "9/6",
      GakusaiDay.bunkasai1 => "9/9",
      GakusaiDay.bunkasai2 => "9/10",
      GakusaiDay.zenkokikaku => "9/11",
    };
  }

  int getTimeAsNumber() {
    return hour * 100 + minute;
  }
}

import 'package:chigusai_app/data/time_data.dart';

class FFDetailData {
  final String title;
  final Time startTime;

  const FFDetailData({required this.title, required this.startTime});
}

class SanbonData {
  static const List<FFDetailData> sanbonDataList = [
    FFDetailData(title: "開会", startTime: Time(hour: 17, day: GakusaiDay.zenkokikaku)),
    FFDetailData(title: "マイムマイム", startTime: Time(hour: 17, minute: 20, day: GakusaiDay.zenkokikaku)),
  ];
}

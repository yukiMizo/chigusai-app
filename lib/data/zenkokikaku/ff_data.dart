import 'package:chigusai_app/data/time_data.dart';

class FFDetailData {
  final String title;
  final Time startTime;

  const FFDetailData({required this.title, required this.startTime});
}

class FFData {
  static const List<FFDetailData> ffDataList = [
    FFDetailData(title: "FF開始挨拶、レク説明", startTime: Time(hour: 17, minute: 15, day: GakusaiDay.zenkokikaku)),
    FFDetailData(title: "マイムマイム①", startTime: Time(hour: 17, minute: 22, day: GakusaiDay.zenkokikaku)),
    FFDetailData(title: "マイムマイム②", startTime: Time(hour: 17, minute: 30, day: GakusaiDay.zenkokikaku)),
    FFDetailData(title: "マイムマイム③", startTime: Time(hour: 17, minute: 37, day: GakusaiDay.zenkokikaku)),
    FFDetailData(title: "挨拶、火文字", startTime: Time(hour: 17, minute: 45, day: GakusaiDay.zenkokikaku)),
    FFDetailData(title: "打ち上げ花火", startTime: Time(hour: 18, minute: 20, day: GakusaiDay.zenkokikaku)),
  ];
}

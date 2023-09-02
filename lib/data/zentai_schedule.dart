import 'time_data.dart';

class ZentaiDetailData {
  final String title;
  final String info;
  final Time startTime;

  const ZentaiDetailData({
    required this.title,
    required this.info,
    required this.startTime,
  });
}

class ZentaiData {
  static const List<ZentaiDetailData> zentaiDataList = [
    ZentaiDetailData(title: "ST", info: "STです", startTime: Time(day: GakusaiDay.zenkokikaku, hour: 9, minute: 0)),
    ZentaiDetailData(title: "歌会", info: "歌会です", startTime: Time(day: GakusaiDay.zenkokikaku, hour: 9, minute: 30)),
  ];
}

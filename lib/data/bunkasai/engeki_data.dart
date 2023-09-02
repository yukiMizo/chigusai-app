import '../time_data.dart';

class EngekiDetailData {
  final String hr;
  final String title;
  final String pr;
  final String imgPath;
  final String soukanImgPath;
  final Time startTime;
  final Time endTime;

  const EngekiDetailData({
    required this.hr,
    required this.title,
    required this.pr,
    required this.imgPath,
    required this.soukanImgPath,
    required this.startTime,
    required this.endTime,
  });
}

class EngekiData {
  static const List<EngekiDetailData> engekiDataList = [
    EngekiDetailData(
      hr: "301",
      title: "301の演劇です",
      pr: "301の演劇だよ",
      imgPath: "assets/images/bunkasai/engeki/301.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/301.jpg",
      startTime: Time(day: GakusaiDay.zenkokikaku, hour: 9, minute: 0),
      endTime: Time(day: GakusaiDay.zenkokikaku, hour: 10, minute: 0),
    )
  ];
}

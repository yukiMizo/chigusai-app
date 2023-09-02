import '../time_data.dart';

class YushiDetailData {
  final String title;
  final Time startTime;
  final String place;
  final String pr;
  final String imgPath;

  const YushiDetailData({
    required this.title,
    required this.startTime,
    required this.place,
    required this.pr,
    required this.imgPath,
  });
}

class YushiData {
  static const List<YushiDetailData> yushiDataList = [
    YushiDetailData(
      title: "マネさんず",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 10, minute: 0),
      pr: "紹介文",
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/yushi.jpg",
    )
  ];
}

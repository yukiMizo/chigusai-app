import 'time_data.dart';

class TaiikusaiDetailData {
  final String title;
  final String? info;
  final Time startTime;
  final bool showResult;

  const TaiikusaiDetailData({
    required this.title,
    this.info,
    required this.startTime,
    this.showResult = false,
  });
}

class TaiikusaiData {
  static const List<TaiikusaiDetailData> taiikusaiDataList = [
    TaiikusaiDetailData(
      title: "開会式",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 8, minute: 45),
    ),
    TaiikusaiDetailData(
      title: "綱引き",
      info: "綱引きです",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 9, minute: 0),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "大玉転がし",
      info: "大玉転がし",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 10, minute: 0),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "玉入れ",
      info: "玉入れだよ",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 11, minute: 0),
      showResult: true,
    ),
  ];
}

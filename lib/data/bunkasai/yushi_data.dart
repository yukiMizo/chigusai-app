import '../time_data.dart';

class YushiDetailData {
  final String title;
  final Time startTime;
  final String place;
  final String imgPath;

  const YushiDetailData({
    required this.title,
    required this.startTime,
    required this.place,
    required this.imgPath,
  });
}

class YushiData {
  static const List<YushiDetailData> yushiDataList = [
    YushiDetailData(
      title: "Boon！",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 10, minute: 30),
      place: "音楽室",
      imgPath: "assets/images/bunkasai/yushi/boonn.jpg",
    ),
    YushiDetailData(
      title: "新旧ゴリラ",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 10, minute: 30),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/sinkyuugorira.jpg",
    ),
    YushiDetailData(
      title: "Norm",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 11, minute: 0),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/nomu.jpg",
    ),
    YushiDetailData(
      title: "ぱなこ",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 11, minute: 30),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/panako.jpg",
    ),
    YushiDetailData(
      title: "Lei may",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 12, minute: 0),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/leimei.jpg",
    ),
    YushiDetailData(
      title: "I♥sis",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 14, minute: 0),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/ilovesis.jpg",
    ),
    YushiDetailData(
      title: "Bloomoon",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 14, minute: 30),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/bloom.jpg",
    ),
    YushiDetailData(
      title: "lovesly",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 15, minute: 0),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/lovesly.jpg",
    ),
    YushiDetailData(
      title: "Take&Rise",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 15, minute: 30),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/take.jpg",
    ),
    YushiDetailData(
      title: "HONEY MELLOW",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 10, minute: 30),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/hanimero.jpg",
    ),
    YushiDetailData(
      title: "二十六夜",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 11, minute: 0),
      place: "音楽室",
      imgPath: "assets/images/bunkasai/yushi/nizyurokuya.jpg",
    ),
    YushiDetailData(
      title: "destruam",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 11, minute: 0),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/destruam.jpg",
    ),
    YushiDetailData(
      title: "Harmonica",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 11, minute: 30),
      place: "音楽室",
      imgPath: "assets/images/bunkasai/yushi/harmonica.jpg",
    ),
    YushiDetailData(
      title: "マネさんず",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 11, minute: 30),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/manesanzu.jpg",
    ),
    YushiDetailData(
      title: "バレー部と俺",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 12, minute: 0),
      place: "音楽室",
      imgPath: "assets/images/bunkasai/yushi/barebutoore.jpg",
    ),
    YushiDetailData(
      title: "べすてぃーず",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 12, minute: 0),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/besutizu.jpg",
    ),
    YushiDetailData(
      title: "キリマンジャロ",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 13, minute: 30),
      place: "音楽室",
      imgPath: "assets/images/bunkasai/yushi/kirimanjaro.jpg",
    ),
    YushiDetailData(
      title: "Nyx",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 13, minute: 30),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/enuyx.jpg",
    ),
    YushiDetailData(
      title: "Ricky's",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 14, minute: 30),
      place: "音楽室",
      imgPath: "assets/images/bunkasai/yushi/ricky.jpg",
    ),
    YushiDetailData(
      title: "JU!C!e-st",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 14, minute: 30),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/jusiesuto.jpg",
    ),
    YushiDetailData(
      title: "なないろさま～",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 15, minute: 0),
      place: "音楽室",
      imgPath: "assets/images/bunkasai/yushi/nanairosama.jpg",
    ),
    YushiDetailData(
      title: "R jeans",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 15, minute: 0),
      place: "メインストリート",
      imgPath: "assets/images/bunkasai/yushi/jeans.jpg",
    ),
  ];
}

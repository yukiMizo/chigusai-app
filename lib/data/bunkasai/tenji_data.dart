class TenjiDetailData {
  final String hr;
  final String title;
  final String pr;
  final String imgPath;

  const TenjiDetailData({
    required this.hr,
    required this.title,
    required this.pr,
    required this.imgPath,
  });
}

class TenjiData {
  static const List<TenjiDetailData> tenjiDataList = [
    TenjiDetailData(
      hr: "101",
      title: "展示名",
      pr: "101のHR発表です",
      imgPath: "assets/images/bunkasai/tenji/101.jpg",
    ),
    TenjiDetailData(
      hr: "102",
      title: "展示名",
      pr: "101のHR発表です",
      imgPath: "assets/images/bunkasai/tenji/101.jpg",
    ),
  ];
}

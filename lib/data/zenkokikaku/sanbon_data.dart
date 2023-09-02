class SanbonDetailData {
  final String title;
  final String imgPath;

  const SanbonDetailData({required this.title, required this.imgPath});
}

class SanbonData {
  static const List<SanbonDetailData> sanbonDataList = [
    SanbonDetailData(title: "ディズニー", imgPath: "assets/images/zenkou/101.jpg"),
  ];
}

class UtakaiDetailData {
  final String title;
  final String imgPath;
  final String pr;

  const UtakaiDetailData({
    required this.title,
    required this.pr,
    required this.imgPath,
  });
}

class UtakaiData {
  static const List<UtakaiDetailData> utakaiDataList = [
    UtakaiDetailData(title: "ディズニー", pr: "", imgPath: "assets/images/zenkou/101.jpg"),
    UtakaiDetailData(title: "ディズニー", pr: "", imgPath: "assets/images/zenkou/101.jpg"),
    UtakaiDetailData(title: "ディズニー", pr: "", imgPath: "assets/images/zenkou/101.jpg"),
    UtakaiDetailData(title: "ディズニー", pr: "", imgPath: "assets/images/zenkou/101.jpg"),
    UtakaiDetailData(title: "ディズニー", pr: "", imgPath: "assets/images/zenkou/101.jpg"),
  ];
}

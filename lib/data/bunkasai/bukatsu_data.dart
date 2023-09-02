class BukatsuDetailData {
  final String club;
  final String place;
  final String pr;
  final String imgPath;

  const BukatsuDetailData({
    required this.club,
    required this.place,
    required this.pr,
    required this.imgPath,
  });
}

class BukatsuData {
  static const List<BukatsuDetailData> bukatsuDataList = [
    BukatsuDetailData(
      club: "インターアクト",
      place: "北館３セミ",
      pr: "説明",
      imgPath: "assets/images/bunkasai/bukatsu/bukatsu.jpg",
    )
  ];
}

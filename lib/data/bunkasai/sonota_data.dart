class EventMerchandiseDetailData {
  final String title;
  final int price;
  final String imgPath;

  const EventMerchandiseDetailData({
    required this.title,
    required this.price,
    required this.imgPath,
  });
}

class SonotaData {
  static const String saikoshiInfo = "再煌市についてとか";
  static const List<EventMerchandiseDetailData> eventMerchandiseList = [
    EventMerchandiseDetailData(
      title: "ラバーバンド",
      price: 300,
      imgPath: "assets/images/bunkasai/sonota/rubber_band.jpg",
    ),
    EventMerchandiseDetailData(
      title: "ラバーバンド",
      price: 300,
      imgPath: "assets/images/bunkasai/sonota/rubber_band.jpg",
    ),
    EventMerchandiseDetailData(
      title: "ラバーバンド",
      price: 300,
      imgPath: "assets/images/bunkasai/sonota/rubber_band.jpg",
    ),
    EventMerchandiseDetailData(
      title: "ラバーバンド",
      price: 300,
      imgPath: "assets/images/bunkasai/sonota/rubber_band.jpg",
    )
  ];
  static const String chigumaInfo = "ちぐまについてとか";
}

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
  static const String saikoshiInfo = "お得な商品と縁日企画のゲームが楽しめる市が文化祭にて開催！準備から運営まで全て生徒が手掛けます。是非遊びに来てください！掘り出し物が見つかるかも！？";
  static const List<EventMerchandiseDetailData> eventMerchandiseList = [
    EventMerchandiseDetailData(
      title: "ラバーバンド",
      price: 250,
      imgPath: "assets/images/bunkasai/sonota/band.jpg",
    ),
    EventMerchandiseDetailData(
      title: "マフラータオル",
      price: 700,
      imgPath: "assets/images/bunkasai/sonota/towel.jpg",
    ),
    EventMerchandiseDetailData(
      title: "ヘアクリップ",
      price: 300,
      imgPath: "assets/images/bunkasai/sonota/clip.jpg",
    ),
    EventMerchandiseDetailData(
      title: "タトゥーシール",
      price: 100,
      imgPath: "assets/images/bunkasai/sonota/tattoo.jpg",
    ),
    EventMerchandiseDetailData(
      title: "ステッカー",
      price: 100,
      imgPath: "assets/images/bunkasai/sonota/sticker1.jpg",
    ),
    EventMerchandiseDetailData(
      title: "ステッカー",
      price: 100,
      imgPath: "assets/images/bunkasai/sonota/sticker2.jpg",
    ),
    EventMerchandiseDetailData(
      title: "ステッカー",
      price: 100,
      imgPath: "assets/images/bunkasai/sonota/sticker3.jpg",
    ),
    EventMerchandiseDetailData(
      title: "ステッカー",
      price: 100,
      imgPath: "assets/images/bunkasai/sonota/sticker4.jpg",
    )
  ];
  static const String chigumaInfo = "千種高校のマスコットキャラクターちぐま！杜若の帽子を被った彼は超キュート！そんなちぐまが文化祭に現れるかも…？！？会えたら是非声をかけてあげてね！！";
}

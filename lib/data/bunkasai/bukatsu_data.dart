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
      club: "インターアクトクラブ",
      place: "メインストリ－ト最煌市",
      pr: "私たちはボランティアや募金など様々な活動をしています！今回は募金活動を行います。",
      imgPath: "assets/images/bunkasai/bukatsu/intaakuto.jpg",
    ),
    BukatsuDetailData(
      club: "華道部",
      place: "本館２F被服室　　1日目終日　2日目~14:00",
      pr: "個人作品や合同作品など様々なお花を使った生け花を展示しています！\n\n癒されること間違いなし！！ぜひ来てください！",
      imgPath: "assets/images/bunkasai/bukatsu/kadou.jpg",
    ),
    BukatsuDetailData(
      club: "美術部",
      place: "サブストリート（雨天時は本館３F美術室）　　1日目~16:00　2日目~15:20",
      pr: "私たち美術部は、今回の文化祭に向けて「フォトスポット」を制作しました！\n\n翼が生えたようなインスタ映えバツグンの写真を撮ることができます！ぜひ友達や家族と一緒に思い出に残る写真を撮りに来てください！",
      imgPath: "assets/images/bunkasai/bukatsu/bizyutu.jpg",
    ),
    BukatsuDetailData(
      club: "写真部",
      place: "北館2F写真部部室",
      pr: "私たちは「夏」をテーマにして自由に作品を制作しました。\n頑張ったので見に来てください(*^_^*)",
      imgPath: "assets/images/bunkasai/bukatsu/syasinn.jpg",
    ),
    BukatsuDetailData(
      club: "演劇部",
      place: "体育館　　2日目14:45~15:40",
      pr: "私たちちぐげきの夏の大会の作品は「リーちゃん３世」です！このお話は自分の顔にコンプレックスを抱える理紗が主人公です。\n\n理紗とその周りの人たちがどのようにかかわっていくのかを見てもらえたらと思います！キャストだけでなく、本物そっくりな大道具や細かいこだわりが沢山詰まっている小道具、照明にも注目してもらえたらうれしいです。\n\n前回県大会に出場したちぐげきが、新たなメンバーを加えて演じる初めての劇です。ぜひ、足を運んでください。",
      imgPath: "assets/images/bunkasai/bukatsu/engeki.jpg",
    ),
    BukatsuDetailData(
      club: "ダンス部（RaGGaCraZe19th、20th）",
      place: "バレーコート　動画配信あり",
      pr: "今年度の学祭では19th（2年）が大会作品、\n20th（1年）が学年曲を披露します！\n\nどちらもすべて自分たちで作った作品なので、多くの方に見てもらいたいです！\n\nぜひ、見に来てください！",
      imgPath: "assets/images/bunkasai/bukatsu/raga.jpg",
    ),
    BukatsuDetailData(
      club: "茶道部",
      place: "本館1F和室　　両日共に①11:00~11:45②12:00~12:45③13:00~13:45",
      pr: "今年度、茶道部ではお茶会を開催します。\n当日券は100円頂くことになりますのでご了承ください。冷房完備、お茶、お菓子付きでいい休憩室にもなるでしょう。\n\nお手前見学のみの場合は無料になりますので気軽に来てください。\n\n部員一同皆様のお越しをお待ちしております！",
      imgPath: "assets/images/bunkasai/bukatsu/sadou.jpg",
    ),
  ];
}

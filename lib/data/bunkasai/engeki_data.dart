import '../time_data.dart';

class EngekiDetailData {
  final String hr;
  final String title;
  final String pr;
  final String imgPath;
  final String soukanImgPath;
  final Time startTime;
  final Time endTime;

  const EngekiDetailData({
    required this.hr,
    required this.title,
    required this.pr,
    required this.imgPath,
    required this.soukanImgPath,
    required this.startTime,
    required this.endTime,
  });
}

class EngekiData {
  static const List<EngekiDetailData> engekiDataList = [
    EngekiDetailData(
      hr: "301",
      title: "School of Rock",
      pr: "ロックしようぜ!!!バンドを追い出されたニート、デューイが家賃を払うためにいとこになりすまして、州一番のフォレスグリーン学園にやってきた!!大人に縛られていた生徒たちにロックの魂を叩きこむ!!",
      imgPath: "assets/images/bunkasai/engeki/301.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/301s.jpg",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 13, minute: 35),
      endTime: Time(day: GakusaiDay.bunkasai2, hour: 14, minute: 30),
    ),
    EngekiDetailData(
      hr: "302",
      title: "Les Misérables",
      pr: "舞台は1815年、フランス。革命後の混沌とした時代を愛と自由のために戦い、生き抜いた人々とひとりの男ジャン・バルジャンの人生の物語です。 愛とはなにか.自由とはなにか。体育館でお待ちしています!",
      imgPath: "assets/images/bunkasai/engeki/302.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/302s.jpg",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 14, minute: 15),
      endTime: Time(day: GakusaiDay.bunkasai1, hour: 15, minute: 10),
    ),
    EngekiDetailData(
      hr: "303",
      title: "キングダム",
      pr: "迫力とかっこ良さが売りの他のクラスとは一味違った 劇になっています! 中国での騒乱が舞台となっていて、登場人物 達が自らの矜持をもって戦いいその中で生まれる深い絆や葛藤が 魅力です。ぜひ見に来て下さい!",
      imgPath: "assets/images/bunkasai/engeki/303.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/303s.jpg",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 10, minute: 5),
      endTime: Time(day: GakusaiDay.bunkasai2, hour: 11),
    ),
    EngekiDetailData(
      hr: "304",
      title: "アナと雪の女王",
      pr: "新しい世界を夢見る妹のアナ。魔法の力を恐れ、感情を抑えて生きる 姉のエルサ。しかし、ある日エルサは力を抑えられず、国中を凍らせてしまう…。愛とは何か、ありのままの自分とは何か。凍った世界を溶かすのは‥",
      imgPath: "assets/images/bunkasai/engeki/304.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/304s.jpg",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 12, minute: 25),
      endTime: Time(day: GakusaiDay.bunkasai2, hour: 13, minute: 20),
    ),
    EngekiDetailData(
      hr: "305",
      title: "天使にラブソングを",
      pr: "殺人現場を目撃した為、元愛人でギャングのヴィンスに命を狙われる ようになった歌手のデロリスが、裁判の日まで修道院でかくまわれることに。 デロリス一体どうなるの~!?ワンワン!",
      imgPath: "assets/images/bunkasai/engeki/305.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/305s.jpg",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 15, minute: 25),
      endTime: Time(day: GakusaiDay.bunkasai1, hour: 16, minute: 20),
    ),
    EngekiDetailData(
      hr: "306",
      title: "夢から醒めた夢",
      pr: "ここは夢の世界。\nそこでピコは幽霊のマコと出会う。マコは交通事故で死に、最後にお別れを言えなかった母に会うため、ピコに1日入れ代わって欲しいと言う。そしてやって来た霊界。そこでピコは素敵な人達と出会いー",
      imgPath: "assets/images/bunkasai/engeki/306.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/306s.jpg",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 13, minute: 05),
      endTime: Time(day: GakusaiDay.bunkasai1, hour: 14),
    ),
    EngekiDetailData(
      hr: "307",
      title: "リメンバーミー",
      pr: "昔、メキシコのサンタセシリアである男がギターを片手に歌を歌った。後に世界中で有名になるその男の名はエルネスト・デラクルス。これは彼の死後、死者の世界に迷い込んだ少年ミゲルが憧れの彼に会いに行く物語である。",
      imgPath: "assets/images/bunkasai/engeki/307.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/307s.jpg",
      startTime: Time(day: GakusaiDay.bunkasai2, hour: 11, minute: 15),
      endTime: Time(day: GakusaiDay.bunkasai2, hour: 12, minute: 10),
    ),
    EngekiDetailData(
      hr: "308",
      title: "帝一の國",
      pr: "天才エリートが通う海帝高校。首席で入学した新入生 赤羽帝一は生徒会長になり、その先に総理大臣になるという 明確な目標がある。彼は強烈な個性を持つライバル たちとの激しい学園権力闘争へと身を投じていく。",
      imgPath: "assets/images/bunkasai/engeki/308.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/308s.jpg",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 10, minute: 45),
      endTime: Time(day: GakusaiDay.bunkasai1, hour: 11, minute: 40),
    ),
    EngekiDetailData(
      hr: "309",
      title: "the SOUND of MUSIC",
      pr: "私修道女のマリア！！ある日院長様からザルツブルクの男爵家の家庭教師になるよう命じられたわ（T＿T）うまくできるか心配・・・信じられる？！7人も子供がいるのよ！！どうなっちゃうの？！",
      imgPath: "assets/images/bunkasai/engeki/309.jpg",
      soukanImgPath: "assets/images/bunkasai/engeki/309s.jpg",
      startTime: Time(day: GakusaiDay.bunkasai1, hour: 11, minute: 55),
      endTime: Time(day: GakusaiDay.bunkasai1, hour: 12, minute: 50),
    ),
  ];
}

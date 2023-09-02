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
      title: "大玉転がし",
      info: "招集時間:応援団演舞披露後すぐ\n招集場所:各ブロテント前\n    （トラック線内には侵入しない）\n※第一試合出場ブロは直接試合場所へ移動\n ※予選突破ブロは予選終了後各ブロテント前にて\n待機すること\n※アンカーの2人はハチマキ(貸し出し)を受け取り、着けること",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 9, minute: 20),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "玉入れ",
      info: "招集時間:大玉第ニ試合終了時\n招集場所:各ブロテント前（トラック線内には侵入しない）\n※第一試合出場者は1人あたり2個玉を持って\n入場すること\n ※予選突破ブロは予選終了後各ブロテント前にて\n待機すること",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 9, minute: 50),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "棒引き",
      info: "招集時間:玉入れ第二試合終了時\n招集場所:バレーコート\n※軍手持参必須(持参していない場合“失格”とする)\n※予選突破ブロは予選終了後各ブロテント前にて\n待機すること",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 10, minute: 20),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "騎馬戦",
      info: "招集時間:棒引き第五試合終了時\n招集場所:バレーコート\n※騎手（上に乗る人）は軍手持参必須\n  （持参していない場合　“失格”　とする）\n※騎手（上に乗る人）は赤白帽着用必須\n   （こちらから貸し出しを行う）\n※予選突破ブロは予選終了後各ブロテント前にて\n待機すること",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 10, minute: 50),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "障害物競走",
      info: "招集時間:騎馬戦第五試合終了時\n招集場所:バレーコート\n※3周目（ラスト1周）を走るアンカー2人はたすき（貸し出し）をバトンとし着用して走ること",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 11, minute: 25),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "昼休憩",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 12),
    ),
    TaiikusaiDetailData(
      title: "マジクラ",
      info: "招集時間:試合開始15分前\n招集場所:バレーコート\n※各部招集前に着替えを済ませ、必要物、バトンとなるものを確実に持ってくること",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 12, minute: 55),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "ブロパフォ",
      info: "招集時間:マジクラ第一試合開始時\n招集場所:バレーコート\n※各ブロック招集前に着替えを済ませ、必要物等を持ってくること",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 13, minute: 15),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "ブロリレ",
      info: "招集時間:Fブロックブロパフォ終了時\n招集場所:バレーコート\n※バトン（貸し出し）を受け取り、走ること",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 13, minute: 45),
      showResult: true,
    ),
    TaiikusaiDetailData(
      title: "閉会式",
      startTime: Time(day: GakusaiDay.taiikusai, hour: 14, minute: 15),
    ),
  ];
}

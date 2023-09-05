import 'package:flutter/material.dart';

import '../../widgets/main_drawer.dart';

import '../notification/notification_screen.dart';

import 'package:chigusai_app/data/zenkokikaku/zenkou_data.dart';
import 'bihin_screen.dart';
import 'sanbon/sanbon_screen.dart';
import 'encore/encore_screen.dart';
import 'ff/ff_screen.dart';
import 'utakai/utakai_screen.dart';

class ZenkoukikakuScreen extends StatelessWidget {
  static const routeName = "/zenkoukikaku-screen";
  const ZenkoukikakuScreen({super.key});

  Widget _buildZenkouCard(BuildContext context, ZenkouDetailData zenkouDetailData, void Function()? onPressed) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          onTap: onPressed,
          leading: Text(
            zenkouDetailData.startTime.getTimeAsString(),
            style: const TextStyle(fontSize: 20),
          ),
          title: Text(
            zenkouDetailData.title,
            style: const TextStyle(fontSize: 20),
          ),
          trailing: zenkouDetailData.zenkouEventType == ZenkouEventType.normal ? null : const Icon(Icons.arrow_forward, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          '全校企画',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void Function()? _onPressed(BuildContext context, ZenkouEventType zenkouEventType) {
    return switch (zenkouEventType) {
      ZenkouEventType.normal => null,
      ZenkouEventType.bihin => () => Navigator.of(context).pushNamed(BihinScreen.routeName),
      ZenkouEventType.encore => () => Navigator.of(context).pushNamed(EncoreScreen.routeName),
      ZenkouEventType.sanbon => () => Navigator.of(context).pushNamed(SabbonScreen.routeName),
      ZenkouEventType.utakai => () => Navigator.of(context).pushNamed(UtakaiScreen.routeName),
      ZenkouEventType.ff => () => Navigator.of(context).pushNamed(FFScreen.routeName),
    };
  }

  @override
  Widget build(BuildContext context) {
    const List<ZenkouDetailData> zenkouDataList = ZenkouData.zenkouDataList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("全校企画"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(NotificationScreen.routeName),
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _buildHeader(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: zenkouDataList.length,
                  itemBuilder: (context, index) {
                    return _buildZenkouCard(
                      context,
                      zenkouDataList[index],
                      _onPressed(context, zenkouDataList[index].zenkouEventType),
                    );
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      drawer: const MainDrawer(),
    );
  }
}

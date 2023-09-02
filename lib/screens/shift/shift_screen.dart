import 'package:flutter/material.dart';

import 'package:chigusai_app/data/time_data.dart';

import 'taiikusai/taiikusai_shift_screen.dart';
import 'bunkasai_shift_screen.dart';

class ShiftScreen extends StatelessWidget {
  static const routeName = "/shift-screen";
  const ShiftScreen({super.key});

  Widget _shiftButton({required String day, required String title, required void Function() onPressed}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          height: 60,
          child: FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              backgroundColor: Colors.deepPurple.shade300,
            ),
            child: Row(
              children: [
                SizedBox(width: 50, child: Text(day, style: const TextStyle(fontSize: 20))),
                const SizedBox(width: 10),
                Text(title, style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        )
        /*Card(
        child: ListTile(
          leading: Text(
            day,
            style: const TextStyle(fontSize: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          onTap: onPressed,
        ),
      ),*/
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("シフト")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          children: [
            _shiftButton(
              day: "9/6",
              title: "体育祭",
              onPressed: () => Navigator.of(context).pushNamed(TaiikusaiShiftScreen.routeName),
            ),
            _shiftButton(
              day: "9/9",
              title: "文化祭1日目",
              onPressed: () => Navigator.of(context).pushNamed(BunkasaiShiftScreen.routeName, arguments: GakusaiDay.bunkasai1),
            ),
            _shiftButton(
              day: "9/10",
              title: "文化祭2日目",
              onPressed: () => Navigator.of(context).pushNamed(BunkasaiShiftScreen.routeName, arguments: GakusaiDay.bunkasai2),
            ),
          ],
        ),
      ),
    );
  }
}

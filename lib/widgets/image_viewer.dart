import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String imgPath;
  const ImageViewer({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showGeneralDialog(
              barrierColor: Colors.black.withOpacity(0.7),
              barrierDismissible: true,
              barrierLabel: "",
              context: context,
              pageBuilder: (context, animation1, animation2) {
                return SafeArea(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InteractiveViewer(
                              minScale: 0.1,
                              maxScale: 5,
                              child: Image.asset(imgPath),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(imgPath),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '※タップで画像をプレビューします。',
              style: TextStyle(fontSize: 12,color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

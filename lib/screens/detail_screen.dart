import 'package:flutter/material.dart';
import 'package:toonflix/widgets/thumb_image_widget.dart';

class DetailScreen extends StatelessWidget {
  final String title, id;
  final Image thumbImg;

  const DetailScreen(
      {super.key,
      required this.title,
      required this.thumbImg,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        centerTitle: true, // detail 화면에서 appBar의 title을 중앙 정렬
        elevation: 2,
        title: Text(
          title,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ThumbImageWidget(thumbImg: thumbImg)],
          ),
        ],
      ),
    );
  }
}

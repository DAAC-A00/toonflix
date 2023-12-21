import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';
import 'package:toonflix/widgets/thumb_image_widget.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final Image thumbImg = Image.network(
        "https://img1.daumcdn.net/thumb/C428x428/?scode=mtistory2&fname=https%3A%2F%2Ftistory1.daumcdn.net%2Ftistory%2F3072371%2Fattach%2F04db9f1b99d5485aba3ab29abd95b154");
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(title: title, thumbImg: thumbImg, id: id)));
      },
      child: Column(
        children: [
          ThumbImageWidget(thumbImg: thumbImg),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

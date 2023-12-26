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
      thumb,
      headers: const {
        "User-Agent":
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
      },
      loadingBuilder: (context, child, loadingProgress) =>
          const CircularProgressIndicator(),
      errorBuilder: (context, error, stackTrace) {
        return const Text(
          '😢',
          style: TextStyle(fontSize: 70),
        );
      },
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumbImg: thumbImg, id: id),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: ThumbImageWidget(thumbImg: thumbImg),
          ),
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

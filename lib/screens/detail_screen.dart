import 'package:flutter/material.dart';
import 'package:toonflix/widgets/thumb_image_widget.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;

  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text(
          "Detail Page Screen Sample",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ThumbImageWidget()],
            ),
          ),
        ],
      ),
    );
  }
}

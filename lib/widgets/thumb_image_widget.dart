import 'package:flutter/material.dart';

class ThumbImageWidget extends StatelessWidget {
  final Image thumbImg;

  const ThumbImageWidget({
    super.key,
    required this.thumbImg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
          blurRadius: 15,
          offset: const Offset(7, 20),
          color: Colors.red.withOpacity(0.5),
        )
      ]),
      child: thumbImg,
    );
  }
}

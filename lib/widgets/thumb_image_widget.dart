import 'package:flutter/material.dart';

class ThumbImageWidget extends StatelessWidget {
  const ThumbImageWidget({
    super.key,
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
      child: Image.network(
          "https://img1.daumcdn.net/thumb/C428x428/?scode=mtistory2&fname=https%3A%2F%2Ftistory1.daumcdn.net%2Ftistory%2F3072371%2Fattach%2F04db9f1b99d5485aba3ab29abd95b154"),
    );
  }
}

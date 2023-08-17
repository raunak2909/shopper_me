import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  int count;
  int index;
  DotIndicator({required this.index, required this.count});

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: count,
      position: index.toDouble(),
      decorator: DotsDecorator(
        size: const Size.square(7.0),
        activeSize: const Size(14.0, 7.0),
        activeColor: Colors.black,
        color: Colors.transparent,
        spacing: EdgeInsets.all(1.5),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(4),
            side: BorderSide(
                color: Colors.black,
                width: 1)),
        activeShape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(5.0)),
      ),
    );
  }
}

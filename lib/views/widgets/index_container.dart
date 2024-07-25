// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class IndexContainer extends StatelessWidget {
  const IndexContainer({
    super.key,
    required this.color,
    required this.index,
    required this.size,
  });

  final Color color;
  final int index;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1,
          color: color,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '$index',
        style: TextStyle(
          color: color,
          fontSize: 20,
        ),
      ),
    );
  }
}

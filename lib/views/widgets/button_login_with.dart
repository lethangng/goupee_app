// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonLoginWith extends StatelessWidget {
  const ButtonLoginWith({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.forColor,
    required this.event,
  });

  final String title;
  final String icon;
  final Color backgroundColor;
  final Color forColor;
  final void Function() event;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: event,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: forColor,
            ),
          )
        ],
      ),
    );
  }
}

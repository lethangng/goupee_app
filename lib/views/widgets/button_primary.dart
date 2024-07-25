// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/text_themes.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    this.event,
    required this.title,
    this.size = double.infinity,
    this.background = const Color(0xFFFF6E47),
    this.vertical = 10,
    this.horizontal = 0,
    this.icon,
  });

  final void Function()? event;
  final String title;
  final double? size;
  final Color background;
  final double vertical;
  final double horizontal;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: FilledButton(
        onPressed: event,
        style: FilledButton.styleFrom(
          backgroundColor: background,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(
            vertical: vertical,
            horizontal: horizontal,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(icon!),
                      const SizedBox(width: 12),
                    ],
                  )
                : const SizedBox(),
            Text(
              title,
              style: TextThemes.text14_600,
            ),
          ],
        ),
      ),
    );
  }
}

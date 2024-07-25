// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/color_app.dart';
import '../../utils/validate.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    this.widget = double.infinity,
    this.height = double.infinity,
    required this.image,
    required this.replaceImage,
  });

  final double widget;
  final double height;
  final String? image;
  final String replaceImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget,
      height: height,
      child: Validate.checkNullEmpty(image)
          ? Image.network(
              image!,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorApp.colorOrange,
                  ),
                );
              },
            )
          : Image.asset(
              replaceImage,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
    );
  }
}

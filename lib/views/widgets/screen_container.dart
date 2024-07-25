// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/color_app.dart';

class ScreenContainer extends StatelessWidget {
  const ScreenContainer({
    super.key,
    this.title,
    this.action,
    required this.widget,
    this.isBottom = false,
  });

  final String? title;
  final List<Widget>? action;
  final Widget widget;
  final bool isBottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.colorBlack2,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          title ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
        actions: action,
        bottom: isBottom
            ? const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(
                  color: Color(0xFF353542),
                  height: 1,
                ),
              )
            : null,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     const Color(0xFFFF9055).withOpacity(0.15),
              //     const Color(0xFF000000).withOpacity(0),
              //     const Color(0xFF3371DB).withOpacity(0.15),
              //   ],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              ),
          child: widget,
        ),
      ),
    );
  }
}

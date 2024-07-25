import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../../utils/color_app.dart';

class ThanhTichScreen extends StatelessWidget {
  const ThanhTichScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Nhiệm vụ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Get.back(),
        ),
      ),
      body: MasonryGridView.count(
        padding: const EdgeInsets.only(
          top: 38,
          // bottom: size.height * 0.1,
          left: 21,
          right: 21,
        ),
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 16,
        itemCount: 7,
        itemBuilder: (context, index) {
          return thanhTichItem(
            image: 'assets/images/thanh-tich-1.png',
            title: 'Tốc thần',
          );
        },
      ),
    );
  }

  Widget thanhTichItem({
    required String image,
    required String title,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(image),
        const SizedBox(height: 9),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

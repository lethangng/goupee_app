import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import 'button_primary.dart';

class LoginEmpty extends StatelessWidget {
  const LoginEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Bạn cần phải đăng nhập để thực hiện chức năng này',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFF6E47),
            ),
          ),
          const SizedBox(height: 20),
          ButtonPrimary(
            title: 'Đăng nhập',
            size: Get.width * 0.5,
            event: () => Get.toNamed(Routes.signup),
          ),
        ],
      ),
    );
  }
}

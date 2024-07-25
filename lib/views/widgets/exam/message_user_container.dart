// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/Exam/question.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/controllers/user_controller.dart';
import '../avatar_container.dart';

class MessageUserContainer extends StatelessWidget {
  MessageUserContainer({
    super.key,
    required this.questionContainer,
  });

  // final String image;
  // final String title;
  final QuestionContainer questionContainer;
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            AvatarContainer(
              radius: 32,
              image: _userController.userRes.value.data!.image,
              replaceImage: 'assets/images/avatar-3.png',
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF312E2E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(1),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  questionContainer.sentenceSearch!.title,
                  style: TextThemes.text14_400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

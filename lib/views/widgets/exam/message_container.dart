// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../models/Exam/question.dart';
import 'message_error_container.dart';
import 'message_res_container.dart';
import 'message_user_container.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
    required this.questionContainer,
    this.event,
  });

  final QuestionContainer questionContainer;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    if (questionContainer.messageType == 'user') {
      return MessageUserContainer(
        questionContainer: questionContainer,
      );
    } else if (questionContainer.messageType == 'res') {
      return MessageResContainer(
        questionContainer: questionContainer,
      );
    } else {
      return const MessageErrorContainer();
    }
  }
}

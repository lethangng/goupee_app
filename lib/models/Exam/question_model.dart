// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'answer_model.dart';
// import 'comment_model.dart';
import 'exam_question_history.dart';
import 'question.dart';

enum AnswerStatus {
  success,
  fail,
  isNull,
  // isWondering,
}

class QuestionModel {
  final int id;
  final String question;
  final List<String> images;
  final RxList<AnswerModel> listAnswer;
  // final RxList<CommentModel> listComment;
  final int g_point;
  final Rx<AnswerStatus> status;
  final RxBool unLock;
  final String right_answer;
  final RxMap<String, dynamic> explain;
  final RxBool isWondering;

  QuestionModel({
    required this.id,
    required this.question,
    required this.images,
    required this.listAnswer,
    // required this.listComment,
    required this.g_point,
    required this.status,
    required this.unLock,
    required this.right_answer,
    required this.explain,
    required this.isWondering,
  });

  factory QuestionModel.fromQuestion(Question question) {
    return QuestionModel(
      id: question.id,
      question: question.content,
      images: question.images,
      listAnswer: <AnswerModel>[
        ...question.quest.entries.map(
          (item) => AnswerModel(
            id: int.parse(item.key),
            // title: getAnswerNumber(int.parse(item.key)),
            title: item.key,
            value: item.value,
            isSelect: false,
            isTrue: item.key == question.right_answer,
          ),
        )
      ].obs,
      // listComment: <CommentModel>[].obs,
      g_point: question.g_point,
      status: AnswerStatus.isNull.obs,
      unLock: false.obs,
      // right_answer: getAnswerNumber(int.parse(question.right_answer)),
      right_answer: question.right_answer,
      explain: <String, dynamic>{}.obs,
      isWondering: false.obs,
    );
  }

  factory QuestionModel.fromQuestionAndHistory(
      Question question, AnswerHistory history) {
    return QuestionModel(
      id: question.id,
      question: question.content,
      images: question.images,
      listAnswer: <AnswerModel>[
        ...question.quest.entries.map(
          (item) => AnswerModel(
            id: int.parse(item.key),
            // title: getAnswerNumber(int.parse(item.key)),
            title: item.key,
            value: item.value,
            isSelect: history.user_answer != null
                ? history.user_answer == item.key
                : false,
            isTrue: item.key == question.right_answer,
          ),
        )
      ].obs,
      // listComment: <CommentModel>[].obs,
      g_point: question.g_point,
      status: history.is_right == 1
          ? AnswerStatus.success.obs
          : AnswerStatus.fail.obs,
      unLock: history.unlock_explain == 0 ? false.obs : true.obs,
      // right_answer: getAnswerNumber(int.parse(question.right_answer)),
      right_answer: question.right_answer,
      explain: <String, dynamic>{}.obs,
      isWondering: false.obs,
    );
  }
}

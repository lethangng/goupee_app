import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/Exam/question.dart';
import '../../models/Exam/sentence_search.dart';
import '../../models/login_models/request_data.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';

class CreateExam2ViewModel extends GetxController {
  late ScrollController controller;

  int examType = 0;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final RxList<QuestionContainer> listQuestionContainer =
      <QuestionContainer>[].obs;

  final Rx<ApiResponse<List<Question>>> questionGenerateRes =
      ApiResponse<List<Question>>.loading().obs;

  final RxList<Question> listQuestion = <Question>[].obs;

  final List<Question> listQuestionVal = <Question>[];

  void setQuestionGenerateRes(ApiResponse<List<Question>> res) {
    questionGenerateRes.value = res;
  }

  void handleDeleteQuestionId(int id) {
    listQuestionVal.removeWhere((q) => q.id == id);
    listQuestion.removeWhere((q) => q.id == id);
    listQuestion.refresh();
  }

  int questionIndex = 0;

  void addQuestion(int count) {
    int indexStart = questionIndex;
    int lengthVal = listQuestionVal.length;

    // Vị trí hiện tại == vị trí tối đa trong List
    if (questionIndex == lengthVal) {
      return;
    } else {
      // Trường hợp vị trí hiện tại < vị trí tối đa
      if (questionIndex + count > lengthVal) {
        count = lengthVal - questionIndex;
      }
      questionIndex += count;
    }

    List<Question> subList = listQuestionVal.sublist(indexStart, questionIndex);
    listQuestion.addAll(subList);
    listQuestion.refresh();
  }

  Future<void> _fetchDataQuestionGenerate(
    RequestData req,
    SentenceSearch sentenceSearch,
  ) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<Question> data = res.map((item) => Question.fromMap(item)).toList();
      setQuestionGenerateRes(ApiResponse.completed(data));

      listQuestionVal.addAll(data);

      addQuestion(3);

      QuestionContainer questionContainer = QuestionContainer(
        sentenceSearch: sentenceSearch,
        listQuestion: data,
        messageType: 'res',
      );

      listQuestionContainer.add(questionContainer);
      listQuestionContainer.refresh();
    } catch (e, s) {
      s.printError();
      setQuestionGenerateRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadQuestionGenerate(
    SentenceSearch sentenceSearch,
    bool isCommand,
  ) async {
    setQuestionGenerateRes(ApiResponse.loading());
    examType = sentenceSearch.exam_type;
    Map data = {
      'suggest_sentence_id': isCommand == false ? sentenceSearch.id : '',
      'command_id': isCommand ? sentenceSearch.id : '',
    };

    RequestData resquestData = RequestData(
      query: 'question_generate',
      data: json.encode(data),
    );

    await _fetchDataQuestionGenerate(resquestData, sentenceSearch);
  }

  late SentenceSearch sentenceSearch;
  late bool isCommand;

  Future<void> handleAddList({
    required SentenceSearch sentenceSearch,
    bool isCommand = false,
  }) async {
    QuestionContainer questionContainer =
        QuestionContainer(sentenceSearch: sentenceSearch);
    listQuestionContainer.add(questionContainer);
    listQuestionContainer.refresh();

    await _handleLoadQuestionGenerate(sentenceSearch, isCommand);
  }

  void _loadMore() {
    if (controller.position.pixels == (controller.position.maxScrollExtent)) {
      addQuestion(3);
    }
  }

  Future<void> handleSubmit(SentenceSearch sentence) async {
    if (sentenceSearch.id == 0) {
      QuestionContainer questionContainer = QuestionContainer(
        sentenceSearch: sentence,
        messageType: 'user',
      );

      QuestionContainer questionContainerRes = QuestionContainer(
        messageType: 'error',
      );

      listQuestionContainer.add(questionContainer);
      listQuestionContainer.add(questionContainerRes);
      listQuestionContainer.refresh();
      return;
    }

    await handleAddList(
      sentenceSearch: sentenceSearch,
      isCommand: true,
    );
  }

  Future<void> initData() async {
    if (isCommand) {
      await handleSubmit(sentenceSearch);
    } else {
      await handleAddList(
        sentenceSearch: sentenceSearch,
        isCommand: false,
      );
    }
  }

  @override
  void onInit() {
    sentenceSearch = Get.arguments['sentenceSearch'];
    isCommand = Get.arguments['isCommand'];
    controller = ScrollController()..addListener(_loadMore);
    initData();
    super.onInit();
  }
}

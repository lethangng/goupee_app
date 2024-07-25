import 'dart:convert';

import 'package:get/get.dart';

// import '../../models/Exam/exam_histoty_add.dart';
import '../../../models/Exam/exam_history.dart';
import '../../../models/Exam/exam_question_history.dart';
import '../../../models/Exam/question.dart';
import '../../../models/Exam/question_model.dart';
import '../../../models/login_models/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';

class ResultScreenViewModel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<ExamQuestionHistory>> examHistoryAddRes =
      ApiResponse<ExamQuestionHistory>.loading().obs;

  final Rx<ApiResponse<List<Question>>> questionRes =
      ApiResponse<List<Question>>.loading().obs;

  final Rx<ApiResponse<String>> explainRes = ApiResponse<String>.loading().obs;

  final List<Question> listQuestionVal = [];
  final Map<String, AnswerHistory> mapQuestionHistory = {};

  // late final int exam_history_id;
  late final ExamHistory examHistoryEdit;

  RxList<QuestionModel> listDataQuestion = <QuestionModel>[
    //
  ].obs;

  late RxInt isSelect;

  void hanleOnSelect(int value) {
    isSelect.value = value;
  }

  void setQuestionRes(ApiResponse<List<Question>> res) {
    questionRes.value = res;
  }

  void setExamHistoryAddRes(ApiResponse<ExamQuestionHistory> res) {
    examHistoryAddRes.value = res;
  }

  void setExplainRes(ApiResponse<String> res) {
    explainRes.value = res;
  }

  Future<void> _fetchDataExamHistoryAdd(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());
      ExamQuestionHistory examHistotyAdd = ExamQuestionHistory.fromMap(res);

      mapQuestionHistory.addAll(examHistotyAdd.history);

      setExamHistoryAddRes(ApiResponse.completed(examHistotyAdd));

      await handleLoadQuestion();
    } catch (e, s) {
      s.printError();
      setExamHistoryAddRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoad() async {
    setExamHistoryAddRes(ApiResponse.loading());

    Map data = {
      'exam_history_id': examHistoryEdit.id,
    };

    RequestData resquestData = RequestData(
      query: 'exam_question_history',
      data: json.encode(data),
    );

    await _fetchDataExamHistoryAdd(resquestData);
  }

  Future<void> _fetchDataQuestion(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());

      List<Question> data = res.map((item) => Question.fromMap(item)).toList();

      listQuestionVal.addAll(data);

      mergeQuestion();
      // listDataQuestion.refresh;

      setQuestionRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setQuestionRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadQuestion() async {
    Map<String, dynamic> data = {
      'exam_id': examHistoryAddRes.value.data!.exam_id,
    };

    RequestData resquestData = RequestData(
      query: 'question_list',
      data: json.encode(data),
    );

    await _fetchDataQuestion(resquestData);
  }

  Future<void> _fetchDataGetQuestionExplain(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());
      String explain = res['explain'];

      setExplainRes(ApiResponse.completed(explain));
    } catch (e, s) {
      s.printError();
      setExplainRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadGetQuestionExplain(int questionId) async {
    setExplainRes(ApiResponse.loading());

    Map data = {
      // 'exam_history_id': exam_history_id,
      'exam_history_id': examHistoryEdit.id,
      'question_id': questionId,
    };

    RequestData resquestData = RequestData(
      query: 'get_question_explain',
      data: json.encode(data),
    );

    await _fetchDataGetQuestionExplain(resquestData);
  }

  Future<void> handleViewDapAn() async {
    //isSelect.value
    QuestionModel questionModel = listDataQuestion[isSelect.value];
    String answer = '';

    for (var item in questionModel.listAnswer) {
      if (item.isTrue) {
        answer = '${item.title}. ${item.value}';
        break;
      }
    }

    int id = listDataQuestion[isSelect.value].id;

    await handleLoadGetQuestionExplain(id).then((_) {
      questionModel.explain.value = {
        'title': answer,
        'value': explainRes.value.data!,
      };
    });

    listDataQuestion[isSelect.value].unLock.value = true;
  }

  void mergeQuestion() {
    mapQuestionHistory.forEach((key, value) {
      Question question =
          listQuestionVal.where((item) => item.id == int.parse(key)).first;
      listDataQuestion
          .add(QuestionModel.fromQuestionAndHistory(question, value));
    });

    listDataQuestion.refresh();
  }

  @override
  void onInit() {
    // exam_history_id = Get.arguments['exam_history_id'];
    examHistoryEdit = Get.arguments['examHistotyEdit'];
    int? quesionId = Get.arguments['question_id'];

    isSelect = quesionId != null ? quesionId.obs : 0.obs;

    handleLoad();

    super.onInit();
  }
}

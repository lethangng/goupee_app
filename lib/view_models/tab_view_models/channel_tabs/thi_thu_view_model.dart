import 'dart:convert';
import 'dart:async';

import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/Exam/answer_model.dart';
import '../../../models/Exam/exam_history.dart';
import '../../../models/Exam/exam_histoty_add.dart';
import '../../../models/Exam/exam_question_history.dart';
import '../../../models/Exam/question.dart';
import '../../../models/Exam/question_model.dart';
import '../../../models/login_models/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';

class ThiThuViewModel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<ExamHistotyAdd>> examHistoryAddRes =
      ApiResponse<ExamHistotyAdd>.loading().obs;

  final Rx<ApiResponse<ExamHistory>> examHistoryEditRes =
      ApiResponse<ExamHistory>.completed(null).obs;

  final Rx<ApiResponse<List<Question>>> questionRes =
      ApiResponse<List<Question>>.loading().obs;

  final Rx<ApiResponse<ExamQuestionHistory>> examHistoryRes =
      ApiResponse<ExamQuestionHistory>.loading().obs;

  final RxList<QuestionModel> listDataQuestion = <QuestionModel>[
    //
  ].obs;

  final List<Question> listQuestionVal = [];

  final Map<String, AnswerHistory> mapQuestionHistory = {};

  late final RxInt isSelect;

  late final int examHistoryId;
  late final ExamHistory? examHistory;
  late final int examId;
  late final int totalQuestion;

  late int remainingTime; // Thời gian còn lại (giây)
  final RxInt minutes = 0.obs; // Phút
  final RxInt seconds = 0.obs; // Giây

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        minutes.value = remainingTime ~/ 60; // Tính phút
        seconds.value = remainingTime % 60; // Tính giây
      } else {
        timer.cancel(); // Dừng timer khi thời gian còn lại đạt 0
      }
    });
  }

  void hanleOnSelect(int value) {
    if (value == -1) return;
    if (value == listDataQuestion.length) return;
    isSelect.value = value;
  }

  void handleWondering() {
    listDataQuestion[isSelect.value].isWondering.value =
        !listDataQuestion[isSelect.value].isWondering.value;
  }

  bool getIsWondering() {
    return listDataQuestion[isSelect.value].isWondering.value;
  }

  void handleSelectAnswer(int id) {
    for (var item in listDataQuestion[isSelect.value].listAnswer) {
      item.isSelect = item.id == id;
    }
    listDataQuestion[isSelect.value].status.value = AnswerStatus.success;
    listDataQuestion[isSelect.value].listAnswer.refresh();
  }

  void setExamHistoryAddRes(ApiResponse<ExamHistotyAdd> res) {
    examHistoryAddRes.value = res;
  }

  void setExamHistoryEditRes(ApiResponse<ExamHistory> res) {
    examHistoryEditRes.value = res;
  }

  void setQuestionRes(ApiResponse<List<Question>> res) {
    questionRes.value = res;
  }

  void setExamHistoryRes(ApiResponse<ExamQuestionHistory> res) {
    examHistoryRes.value = res;
  }

  Future<void> _fetchDataExamHistory(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());
      ExamQuestionHistory examHistotyAdd = ExamQuestionHistory.fromMap(res);

      mapQuestionHistory.addAll(examHistotyAdd.history);
      mergeQuestion();

      remainingTime = examHistory!.limit_time - examHistory!.total_time!;

      setExamHistoryRes(ApiResponse.completed(examHistotyAdd));
      // await handleLoadQuestion();

      startTimer();
    } catch (e, s) {
      s.printError();
      setExamHistoryRes(ApiResponse.error(e.toString()));
    }
  }

  // Lấy ra câu trả lời của các câu hỏi trong đề thi
  Future<void> handleLoadExamHistory() async {
    setExamHistoryRes(ApiResponse.loading());

    Map data = {
      'exam_history_id': examHistory!.id,
    };

    RequestData resquestData = RequestData(
      query: 'exam_question_history',
      data: json.encode(data),
    );

    await _fetchDataExamHistory(resquestData);
  }

  Future<void> _fetchDataQuestion(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());

      List<Question> data = res.map((item) => Question.fromMap(item)).toList();

      listQuestionVal.addAll(data);

      setQuestionRes(ApiResponse.completed(data));

      // Nếu người dùng chọn "Làm lại từ đầu" hoặc "Làm mới" thì vào else
      // Nếu người dùng chọn "Làm tiếp" thì examHistory sẽ có giá trị
      if (examHistory != null) {
        await handleLoadExamHistory();
      } else {
        await handleLoad();
      }
    } catch (e, s) {
      s.printError();
      setQuestionRes(ApiResponse.error(e.toString()));
    }
  }

  // Lấy ra toàn bộ câu hỏi trong đề thi
  Future<void> handleLoadQuestion() async {
    setQuestionRes(ApiResponse.loading());
    Map<String, dynamic> data = {
      'exam_id': examId,
    };

    RequestData resquestData = RequestData(
      query: 'question_list',
      data: json.encode(data),
    );

    await _fetchDataQuestion(resquestData);
  }

  Future<void> _fetchDataExamHistoryAdd(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());
      ExamHistotyAdd examHistotyAdd = ExamHistotyAdd.fromMap(res);

      List<String> listQuestion = examHistotyAdd.list_question;
      remainingTime = examHistotyAdd.limit_time;

      listDataQuestion.addAll(
        listQuestion
            .map((item) => listQuestionVal
                .firstWhere((element) => element.id.toString() == item))
            .map((item) => QuestionModel.fromQuestion(item))
            .toList(),
      );

      setExamHistoryAddRes(ApiResponse.completed(examHistotyAdd));

      startTimer();
    } catch (e, s) {
      s.printError();
      setExamHistoryAddRes(ApiResponse.error(e.toString()));
    }
  }

  // Dành cho "Làm lại từ đầu" hoặc "Làm mới làm thi"
  Future<void> handleLoad() async {
    setExamHistoryAddRes(ApiResponse.loading());

    Map data = examHistoryId == 0
        ? {
            'exam_id': examId,
            'total_question': totalQuestion,
            'type': 1,
          }
        : {
            'exam_history_id': examHistoryId,
          };

    RequestData resquestData = RequestData(
      query: examHistoryId == 0 ? 'exam_history_add' : 'exam_history_refresh',
      data: json.encode(data),
    );

    await _fetchDataExamHistoryAdd(resquestData);
  }

  Future<void> _fetchDataExamHistoryEdit(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());
      ExamHistory examHistotyEdit = ExamHistory.fromMap(res);

      setExamHistoryEditRes(ApiResponse.completed(examHistotyEdit));
      Get.offAllNamed(Routes.examResult, arguments: {
        'examHistotyEdit': examHistotyEdit,
      });
    } catch (e, s) {
      s.printError();
      setExamHistoryEditRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadEdit(int status) async {
    setExamHistoryEditRes(ApiResponse.loading());

    Map data = {
      'exam_history_id':
          examHistoryAddRes.value.data?.exam_history_id ?? examHistoryId,
      'result': getMapAnswer(),
      'remain_time': remainingTime,
      'status': status,
      'start_from': isSelect.value,
    };

    RequestData resquestData = RequestData(
      query: 'exam_history_edit',
      data: json.encode(data),
    );

    await _fetchDataExamHistoryEdit(resquestData);
  }

  // Lấy ra list câu trả lời của người dùng
  Map<String, dynamic> getMapAnswer() {
    Map<String, dynamic> mapAnswer = {};
    for (var item in listDataQuestion) {
      AnswerModel? answer =
          item.listAnswer.firstWhereOrNull((item) => item.isSelect);
      mapAnswer['${item.id}'] = {
        'answer': answer?.id,
        'remain': null,
      };
    }
    return mapAnswer;
  }

  List<String?> listPreview = <String?>[];
  int questionNotNull = 0;

  void handlePreview() {
    listPreview = [];
    questionNotNull = 0;
    for (var item in listDataQuestion) {
      AnswerModel? answer =
          item.listAnswer.firstWhereOrNull((item) => item.isSelect);
      if (answer != null) questionNotNull++;
      listPreview.add(answer?.title);
    }
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

  Future<void> initData() async {
    int? startFrom = Get.arguments['start_from'];
    isSelect = startFrom != null ? startFrom.obs : 0.obs;

    // Được gửi từ màn "Chi tiết đề thi"
    examHistoryId = Get.arguments['examHistoryId'] ?? 0;

    // Được gửi từ màn "Chưa xong"
    examHistory = Get.arguments['examHistory'];

    examId = Get.arguments['examId'] ?? 0;
    totalQuestion = Get.arguments['totalQuestion'] ?? 0;

    // await handleLoad();
    await handleLoadQuestion();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}

// import 'package:comment_tree/comment_tree.dart';
// import 'dart:convert';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../models/Exam/comment.dart';
import '../../../models/Exam/exam_histoty_add.dart';
import '../../../models/Exam/question.dart';
import '../../../models/Exam/question_model.dart';
import '../../../models/login_models/request_data.dart';
import '../../../models/upload/upload_file_model.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
// import '../../../views/widgets/comment/comment.dart';
import 'exam_detail_view_model.dart';

class OnThiViewModel extends GetxController {
  final ExamDetailViewModel _examDetailViewModel =
      Get.find<ExamDetailViewModel>();
  RxList<QuestionModel> listDataQuestion = <QuestionModel>[].obs;

  final RxInt isSelect = 0.obs;
  final RxInt totalComment = 0.obs;
  final RxBool showElement = true.obs;

  Future<void> handleShowElement() async {
    Future.delayed(const Duration(seconds: 5), () {
      showElement.value = false;
    });
  }

  void hanleOnSelect(int value) {
    if (value < 0 || value > listDataQuestion.length - 1) {
      return;
    }
    handleLoadComment();
    isSelect.value = value;
  }

  void handleSelectAnswer(int id) {
    for (var item in listDataQuestion[isSelect.value].listAnswer) {
      item.isSelect = false;
      if (item.id == id) {
        item.isSelect = true;
      }
    }
    listDataQuestion[isSelect.value].listAnswer.refresh();
  }

  void hanleSubmitAnswer(bool isTrue) {
    listDataQuestion[isSelect.value].status.value =
        isTrue ? AnswerStatus.success : AnswerStatus.fail;
  }

  final int _page = 1;

  final Rx<ApiResponse<ExamHistotyAdd>> examHistoryAddRes =
      ApiResponse<ExamHistotyAdd>.loading().obs;

  final Rx<ApiResponse<String>> explainRes = ApiResponse<String>.loading().obs;
  final Rx<ApiResponse<bool>> rateRes = ApiResponse<bool>.completed(false).obs;

  final Rx<ApiResponse<CommentModel>> commentRes =
      ApiResponse<CommentModel>.loading().obs;

  final Rx<ApiResponse<bool>> commentAddRes =
      ApiResponse<bool>.completed(null).obs;

  final Rx<ApiResponse<bool>> commentEditRes =
      ApiResponse<bool>.completed(null).obs;

  final Rx<ApiResponse<bool>> commentDeleteRes =
      ApiResponse<bool>.completed(null).obs;

  final Rx<ApiResponse<bool>> commentUpdateStatusRes =
      ApiResponse<bool>.completed(null).obs;

  final Rx<ApiResponse<bool>> commentAddFavoriteRes =
      ApiResponse<bool>.completed(null).obs;

  final Rx<ApiResponse<bool>> uploadImageRes =
      ApiResponse<bool>.completed(true).obs;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final RxList<Question> listQuestion = <Question>[].obs;
  final RxList<Comment> listComment = <Comment>[].obs;

  String imageUrl = '';

  void setExamHistoryAddRes(ApiResponse<ExamHistotyAdd> res) {
    examHistoryAddRes.value = res;
  }

  void setExplainRes(ApiResponse<String> res) {
    explainRes.value = res;
  }

  void setRateRes(ApiResponse<bool> res) {
    rateRes.value = res;
  }

  void setCommentRes(ApiResponse<CommentModel> res) {
    commentRes.value = res;
  }

  void setCommentAddRes(ApiResponse<bool> res) {
    commentAddRes.value = res;
  }

  void setCommentEditRes(ApiResponse<bool> res) {
    commentEditRes.value = res;
  }

  void setCommentDeleteRes(ApiResponse<bool> res) {
    commentDeleteRes.value = res;
  }

  void setCommentUpdateStatusRes(ApiResponse<bool> res) {
    commentUpdateStatusRes.value = res;
  }

  void setCommentAddFavoriteRes(ApiResponse<bool> res) {
    commentAddFavoriteRes.value = res;
  }

  void setUploadImageRes(ApiResponse<bool> res) {
    uploadImageRes.value = res;
  }

  Future<void> _uploadData(UploadFileModel req) async {
    setUploadImageRes(ApiResponse.loading());
    try {
      final String res = await _accessServerRepository.uploadFile(req);

      imageUrl = '${Configs.domain}/$res';

      setUploadImageRes(ApiResponse.completed(true));
    } catch (e, s) {
      s.printError();
      setUploadImageRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleUploadImage(File file) async {
    Map<String, dynamic> data = {
      //
    };

    RequestData requestData = RequestData(
      query: 'upload_image',
      data: json.encode(data),
    );

    UploadFileModel uploadFileModel = UploadFileModel(
      requestData: requestData.toMap(),
      file: file,
    );

    await _uploadData(uploadFileModel);
  }

  Future<void> _fetchDataAddFavoriteComment(RequestData req) async {
    try {
      setCommentAddFavoriteRes(ApiResponse.loading());

      await _accessServerRepository.postData(req.toMap());

      // Get.back();

      // Get.snackbar(
      //   'Thông báo',
      //   'Ẩn comment thành công.',
      //   icon: const Icon(Icons.check, color: Colors.green),
      //   colorText: Colors.white,
      //   backgroundColor: const Color(0xFF312E2E),
      // );

      setCommentAddFavoriteRes(ApiResponse.completed(true));
      await handleLoadComment();
    } catch (e, s) {
      s.printError();
      setCommentAddFavoriteRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadAddFavoriteComment(int commentId) async {
    Map<String, dynamic> data = {
      'comment_id': commentId,
    };

    RequestData resquestData = RequestData(
      query: 'comment_add_favourite',
      data: json.encode(data),
    );

    await _fetchDataAddFavoriteComment(resquestData);
  }

  Future<void> _fetchDataUpdateStatusComment(RequestData req) async {
    try {
      setCommentUpdateStatusRes(ApiResponse.loading());

      await _accessServerRepository.postData(req.toMap());

      Get.back();

      Get.snackbar(
        'Thông báo',
        'Ẩn comment thành công.',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: const Color(0xFF312E2E),
      );

      setCommentUpdateStatusRes(ApiResponse.completed(true));
      await handleLoadComment();
    } catch (e, s) {
      s.printError();
      setCommentUpdateStatusRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadUpdateStatusComment(int commentId) async {
    Map<String, dynamic> data = {
      'comment_id': commentId,
    };

    RequestData resquestData = RequestData(
      query: 'comment_change_status',
      data: json.encode(data),
    );

    await _fetchDataUpdateStatusComment(resquestData);
  }

  Future<void> _fetchDataDeleteComment(RequestData req) async {
    try {
      setCommentDeleteRes(ApiResponse.loading());

      await _accessServerRepository.postData(req.toMap());

      Get.back();

      Get.snackbar(
        'Thông báo',
        'Xóa comment thành công.',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: const Color(0xFF312E2E),
      );

      setCommentDeleteRes(ApiResponse.completed(true));
      await handleLoadComment();
    } catch (e, s) {
      s.printError();
      setCommentDeleteRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadDeleteComment(int commentId) async {
    Map<String, dynamic> data = {
      'comment_id': commentId,
    };

    RequestData resquestData = RequestData(
      query: 'comment_delete',
      data: json.encode(data),
    );

    await _fetchDataDeleteComment(resquestData);
  }

  Future<void> _fetchDataEditComment(RequestData req) async {
    try {
      setCommentEditRes(ApiResponse.loading());

      await _accessServerRepository.postData(req.toMap());

      Get.back();
      Get.back();

      Get.snackbar(
        'Thông báo',
        'Chỉnh sửa comment thành công.',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: const Color(0xFF312E2E),
      );

      setCommentEditRes(ApiResponse.completed(true));
      await handleLoadComment();
    } catch (e, s) {
      s.printError();
      setCommentEditRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadEditComment({
    required int commentId,
    required String content,
    // File? file,
  }) async {
    // if (file != null) {
    //   await handleUploadImage(file);
    // }

    Map<String, dynamic> data = {
      'comment_id': commentId,
      'content': content,
      // 'images': imageUrl,
      'images': '',
    };

    RequestData resquestData = RequestData(
      query: 'comment_edit',
      data: json.encode(data),
    );

    await _fetchDataEditComment(resquestData);
  }

  Future<void> _fetchDataAddComment(RequestData req) async {
    try {
      setCommentAddRes(ApiResponse.loading());

      await _accessServerRepository.postData(req.toMap());

      Get.snackbar(
        'Thông báo',
        'Comment thành công.',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: const Color(0xFF312E2E),
      );

      setCommentAddRes(ApiResponse.completed(true));
      await handleLoadComment();
    } catch (e, s) {
      s.printError();
      setCommentAddRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadAddComment({
    required String content,
    required int prarentId,
    required int userRefer,
    File? file,
  }) async {
    if (file != null) {
      await handleUploadImage(file);
    }

    Map<String, dynamic> data = {
      'exam_id': _examDetailViewModel.examId,
      'question_id': listDataQuestion[isSelect.value].id,
      'parent_id': prarentId != -1 ? prarentId : '',
      'user_refer': userRefer != -1 ? userRefer : '',
      'content': content,
      'images': imageUrl,
    };

    RequestData resquestData = RequestData(
      query: 'comment_add',
      data: json.encode(data),
    );

    await _fetchDataAddComment(resquestData);
  }

  Future<void> _fetchDataComment(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());

      CommentModel data = CommentModel.fromMap(res);
      // final List comments = res['comments'];

      // List<Comment> listComm =
      //     comments.map((item) => Comment.fromMap(item)).toList();

      if (_page == 1) {
        totalComment.value = data.total_result ?? 0;
      }

      listComment.clear();
      listComment.addAll(data.comments);
      listComment.refresh();
      setCommentRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setRateRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadComment() async {
    setRateRes(ApiResponse.loading());

    Map data = {
      'exam_id': _examDetailViewModel.examId,
      'question_id': listDataQuestion[isSelect.value].id,
      'parent_id': '',
      'page': _page,
      'get_total': _page == 1 ? 1 : '',
    };

    RequestData resquestData = RequestData(
      query: 'comment_list',
      data: json.encode(data),
    );

    await _fetchDataComment(resquestData);
  }

  Future<void> _fetchDataRate(RequestData req) async {
    try {
      await _accessServerRepository.postData(req.toMap());

      setRateRes(ApiResponse.completed(true));
      Get.back();
    } catch (e, s) {
      s.printError();
      setRateRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadRate(int star, String content) async {
    setRateRes(ApiResponse.loading());

    Map data = {
      'exam_id': _examDetailViewModel.examId,
      'star': star,
      'content': content,
    };

    RequestData resquestData = RequestData(
      query: 'rate_add',
      data: json.encode(data),
    );

    await _fetchDataRate(resquestData);
  }

  Future<void> _fetchDataExamHistoryAdd(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());
      ExamHistotyAdd examHistotyAdd = ExamHistotyAdd.fromMap(res);

      setExamHistoryAddRes(ApiResponse.completed(examHistotyAdd));
    } catch (e, s) {
      s.printError();
      setExamHistoryAddRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoad() async {
    setExamHistoryAddRes(ApiResponse.loading());

    Map data = {
      'exam_id': _examDetailViewModel.examId,
      'total_question': _examDetailViewModel.listQuestionVal.length,
      'type': 0,
    };

    RequestData resquestData = RequestData(
      query: 'exam_history_add',
      data: json.encode(data),
    );

    await _fetchDataExamHistoryAdd(resquestData);
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
      'exam_history_id': examHistoryAddRes.value.data!.exam_history_id,
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

  Future<void> initData() async {
    await handleLoad();
    listDataQuestion.addAll(_examDetailViewModel.listQuestionVal
        .map((item) => QuestionModel.fromQuestion(item))
        .toList());
    await handleLoadComment();
    await handleShowElement();
  }

  @override
  void onInit() {
    initData();

    super.onInit();
  }
}

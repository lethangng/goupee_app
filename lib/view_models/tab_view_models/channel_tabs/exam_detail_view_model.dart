import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../models/Exam/CommentModel.dart';
import '../../../configs/configs.dart';
import '../../../models/Exam/comment.dart';
import '../../../models/Exam/exam_detail_response.dart';
import '../../../models/Exam/question.dart';
// import '../../../models/home_models/comment_model_test.dart';
import '../../../models/login_models/request_data.dart';
import '../../../models/upload/upload_file_model.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';

String getAnswerNumber(int index) {
  index = index + 64;
  if (index < 65) index = 65;
  if (index > 90) {
    int prefix = ((index - 65) / 26).floor();
    int suffix = index - 64 - prefix * 26;
    return getAnswerNumber(prefix) + getAnswerNumber(suffix);
  } else {
    return String.fromCharCode(index);
  }
}

class SelectQuestion {
  final int questionIndex;
  final int? questionId;

  SelectQuestion({
    this.questionIndex = -1,
    this.questionId,
  });
}

class ExamDetailViewModel extends GetxController {
  final RxBool isShow = false.obs;
  final RxBool isXemDapAn = false.obs;

  void onXemDapAn(bool? value) {
    if (value == null) return;
    isXemDapAn.value = value;
  }

  void onShow() {
    isShow.value = true;
  }

  final Rx<ApiResponse<ExamDetailResponse>> examDetailRes =
      ApiResponse<ExamDetailResponse>.loading().obs;

  final Rx<ApiResponse<List<Question>>> questionRes =
      ApiResponse<List<Question>>.loading().obs;

  final Rx<ApiResponse<CommentModel>> commentRes =
      ApiResponse<CommentModel>.loading().obs;

  final Rx<ApiResponse<bool>> changeFavoriteRes =
      ApiResponse<bool>.loading().obs;

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

  final Rx<ApiResponse<bool>> donateRes = ApiResponse<bool>.loading().obs;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  late int examId;

  final RxBool isFavorite = false.obs;
  final RxInt totalFavorite = 0.obs;

  final RxList<Question> listDataQuestion = <Question>[].obs;
  final RxList<Comment> listDataComment = <Comment>[].obs;
  final List<Question> listQuestionVal = [];

  int questionIndex = 0;

  final int _page = 1;

  String imageUrl = '';

  final Rx<SelectQuestion> selectIndexQuestion = SelectQuestion().obs;

  final List<Map<String, int>> colorHashtag = [
    {
      'textColor': 0xFF5E00F5,
      'backgroundColor': 0xFFE4D3FF,
    },
    {
      'textColor': 0xFFFF4C1C,
      'backgroundColor': 0xFFFFD2CC,
    },
  ];

  void setSelectIndexQuestion(SelectQuestion value) {
    selectIndexQuestion.value = value;
  }

  void setExamDetailRes(ApiResponse<ExamDetailResponse> res) {
    examDetailRes.value = res;
  }

  void setQuestionRes(ApiResponse<List<Question>> res) {
    questionRes.value = res;
  }

  void setCommentRes(ApiResponse<CommentModel> res) {
    commentRes.value = res;
  }

  void setChangeFavoriteRes(ApiResponse<bool> res) {
    changeFavoriteRes.value = res;
  }

  void setCommentAddRes(ApiResponse<bool> res) {
    commentAddRes.value = res;
  }

  void setDonateRes(ApiResponse<bool> res) {
    donateRes.value = res;
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
    listDataQuestion.addAll(subList);
    listDataQuestion.refresh();
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
      handleLoadComment();
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
    Map<String, dynamic> data = {
      'exam_id': examId,
      'question_id': selectIndexQuestion.value.questionId ?? '',
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

  Future<void> _fetchDataDonate(RequestData req) async {
    try {
      setDonateRes(ApiResponse.loading());

      await _accessServerRepository.postData(req.toMap());

      Get.snackbar(
        'Thông báo',
        'Donate thành công.',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        backgroundColor: const Color(0xFF312E2E),
      );

      setDonateRes(ApiResponse.completed(true));
    } catch (e, s) {
      s.printError();
      setDonateRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadDonate() async {
    Map<String, dynamic> data = {
      'exam_id': examId,
      'g_point': 1,
    };

    RequestData resquestData = RequestData(
      query: 'exam_donate',
      data: json.encode(data),
    );

    _fetchDataDonate(resquestData);
  }

  Future<void> _fetchDataChangeFavorite(RequestData req) async {
    try {
      setChangeFavoriteRes(ApiResponse.loading());

      await _accessServerRepository.postData(req.toMap());
      if (isFavorite.value) {
        totalFavorite.value--;
      } else {
        totalFavorite.value++;
      }

      isFavorite.value = !isFavorite.value;

      setChangeFavoriteRes(ApiResponse.completed(true));
    } catch (e, s) {
      s.printError();
      setChangeFavoriteRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadChangeFavorite() async {
    Map<String, dynamic> data = {
      'exam_id': examId,
    };

    RequestData resquestData = RequestData(
      query: 'exam_change_favourite',
      data: json.encode(data),
    );

    _fetchDataChangeFavorite(resquestData);
  }

  Future<void> _fetchDataComment(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());

      CommentModel data = CommentModel.fromMap(res);

      listDataComment.clear();
      listDataComment.addAll(data.comments);
      listDataComment.refresh();

      setCommentRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setCommentRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadComment() async {
    Map<String, dynamic> data = {
      'exam_id': examId,
      'question_id': '',
      'parent_id': '',
      'page': _page,
      'get_total': '',
    };

    RequestData resquestData = RequestData(
      query: 'comment_list',
      data: json.encode(data),
    );

    _fetchDataComment(resquestData);
  }

  Future<void> _fetchDataQuestion(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());

      List<Question> data = res.map((item) => Question.fromMap(item)).toList();

      listQuestionVal.addAll(data);

      addQuestion(3);

      setQuestionRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setQuestionRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadQuestion() async {
    setQuestionRes(ApiResponse.loading());
    Map<String, dynamic> data = {
      'exam_id': examId,
    };

    RequestData resquestData = RequestData(
      query: 'question_list',
      data: json.encode(data),
    );

    _fetchDataQuestion(resquestData);
  }

  Future<void> _fetchDataExamDetail(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());

      ExamDetailResponse data = ExamDetailResponse.fromMap(res);
      if (data.is_favourited != null) isFavorite.value = true;
      totalFavorite.value = data.exam_detail.total_favourites;

      setExamDetailRes(ApiResponse.completed(data));
      handleLoadQuestion();
    } catch (e, s) {
      s.printError();
      setExamDetailRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadExamDetail() async {
    Map<String, dynamic> data = {
      'exam_id': examId,
    };

    RequestData resquestData = RequestData(
      query: 'exam_detail',
      data: json.encode(data),
    );

    _fetchDataExamDetail(resquestData);
  }

  Future<void> initData() async {
    await Future.wait([
      handleLoadExamDetail(),
      handleLoadComment(),
    ]);
  }

  @override
  void onInit() {
    examId = Get.arguments['examId'];

    initData();
    super.onInit();
  }
}

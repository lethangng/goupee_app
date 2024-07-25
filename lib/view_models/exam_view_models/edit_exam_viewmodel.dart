import 'dart:convert';

import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../models/Exam/exam_detail_response.dart';
import '../../models/Exam/question.dart';
import '../../models/login_models/request_data.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../tab_view_models/channel_tabs/exam_detail_view_model.dart';

class EditExamViewmodel extends GetxController {
  final ExamDetailViewModel _examDetailViewModel =
      Get.find<ExamDetailViewModel>();
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final Rx<ApiResponse<bool>> editExamRes =
      ApiResponse<bool>.completed(null).obs;

  late final RxList<Question> listQuestionVal;

  void setEditExam(ApiResponse<bool> value) {
    editExamRes.value = value;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      int examId = await _accessServerRepository.postData(req.toMap());

      setEditExam(ApiResponse.completed(true));
      // Get.toNamed(Routes.exportExamSusscess);
      Get.offAllNamed(Routes.exportExamSusscess, arguments: {
        'examId': examId,
        'type': 'delete',
      });
    } catch (e, s) {
      s.printError();
      setEditExam(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadDelete() async {
    setEditExam(ApiResponse.loading());

    ExamDetailResponse examDetail =
        _examDetailViewModel.examDetailRes.value.data!;

    Map data = {
      'exam_id': examDetail.exam_detail.id,
      'mascot_id': examDetail.mascot_info.id,
      'title': examDetail.exam_detail.title,
      'description': examDetail.exam_detail.description,
      'image': examDetail.exam_detail.image,
      'list_question': [],
      'hashtag_list': examDetail.hashtags,
      'is_public': 1,
    };

    RequestData resquestData = RequestData(
      query: 'exam_edit',
      data: json.encode(data),
    );

    await _fetchData(resquestData);
  }

  void handleDeleteQuestionId(int id) {
    listQuestionVal.removeWhere((q) => q.id == id);
    listQuestionVal.refresh();
  }

  @override
  void onInit() {
    listQuestionVal = _examDetailViewModel.listQuestionVal.obs;
    super.onInit();
  }
}

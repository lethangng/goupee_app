import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/home_models/exam_item_model.dart';
import '../../../models/home_models/mascot_item.dart';
import '../../../models/login_models/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';

class MascotViewModel extends GetxController {
  late Rx<MascotItem> mascotSelect;
  final RxList<MascotItem> listData = <MascotItem>[].obs;
  final RxList<ExamItemModel> listExam = <ExamItemModel>[].obs;
  late int userId;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  int _page = 1;
  int _pageExam = 1;

  final Rx<ApiResponse<List<MascotItem>>> mascotRes =
      ApiResponse<List<MascotItem>>.loading().obs;
  final Rx<ApiResponse<List<ExamItemModel>>> examRes =
      ApiResponse<List<ExamItemModel>>.loading().obs;

  void setLinhVatRes(ApiResponse<List<MascotItem>> res) {
    mascotRes.value = res;
  }

  void setExamRes(ApiResponse<List<ExamItemModel>> res) {
    examRes.value = res;
  }

  void setLinhVatSelect(MascotItem value) {
    mascotSelect.value = value;
  }

  void handleChangeLinhVatSelect(MascotItem linhVat) {
    setLinhVatSelect(linhVat);
    _handleLoadExam(isChangeLinhVat: true);
  }

  Future<void> _fetchExamData(RequestData req, bool isChangeLinhVat) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<ExamItemModel> data =
          res.map((item) => ExamItemModel.fromMap(item)).toList();
      setExamRes(ApiResponse.completed(data));

      if (isChangeLinhVat) {
        listExam.value = [];
      }

      listExam.addAll(data);
      listExam.refresh();
    } catch (e, s) {
      s.printError();
      setExamRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadExam({bool isChangeLinhVat = false}) async {
    Map data = {
      'page': _pageExam,
      'exam_ids': '',
      'mascot_id': mascotSelect.value.id,
      'user_id': '',
    };

    RequestData resquestData = RequestData(
      query: 'exam_list',
      data: json.encode(data),
    );

    await _fetchExamData(resquestData, isChangeLinhVat);
  }

  Future<void> onLoadingExam() async {
    _pageExam++;
    await _handleLoadExam();
    refreshController.loadComplete();
  }

  // Future<void> onRefreshExam() async {
  //   _pageExam = 1;
  //   listData.value = [];
  //   await _handleLoadExam();
  //   refreshControllerExam.refreshCompleted();
  // }

  Future<void> _fetchData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<MascotItem> data =
          res.map((item) => MascotItem.fromMap(item)).toList();
      setLinhVatRes(ApiResponse.completed(data));
      listData.addAll(data);

      // 1. Loai bo linhVat da duoc truyen tu man khac qua
      // 2. Them phan tu duoc truyen tu man khac vao dau mang
      listData.removeWhere((linhVat) => linhVat == mascotSelect.value);
      listData.insert(0, mascotSelect.value);

      listData.refresh();
    } catch (e, s) {
      s.printError();
      setLinhVatRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map data = {
      'key': '',
      'page': _page,
      'user_id': userId,
      'channel_id': '',
    };

    RequestData resquestData = RequestData(
      query: 'mascot_list',
      data: json.encode(data),
    );

    _fetchData(resquestData);
  }

  // Future<void> onLoading() async {
  //   _page++;
  //   await _handleLoad();
  //   refreshController.loadComplete();
  // }

  Future<void> onRefresh() async {
    _page = 1;
    _pageExam = 1;
    listData.value = [];
    listExam.value = [];
    await _handleLoad();
    await _handleLoadExam();
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    final MascotItem? paramValue = Get.arguments['linhVat'];
    if (paramValue != null) {
      mascotSelect = paramValue.obs;

      userId = paramValue.user_id;
      _handleLoad();
      _handleLoadExam();
    }
    super.onInit();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}

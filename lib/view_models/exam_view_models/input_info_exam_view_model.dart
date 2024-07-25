import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../configs/configs.dart';
import '../../database/tables/token_table.dart';
import '../../models/home_models/hashtag.dart';
import '../../models/home_models/mascot_item.dart';
import '../../models/login_models/form_data.dart';
import '../../models/login_models/request_data.dart';
import '../../models/upload/upload_file_model.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';
import '../controllers/app_data_controller.dart';

class InputInfoExamViewModel extends GetxController {
  final AppDataController _appDataController = Get.find<AppDataController>();
  final RxList<MascotItem> listMascot = <MascotItem>[].obs;
  final RxList<Hashtag> listHashtag = <Hashtag>[].obs;

  final Rx<ApiResponse<bool>> uploadImageRes =
      ApiResponse<bool>.completed(true).obs;

  late final List<int> listQusestionId;
  late final int examType;
  late final String sampleExamTitle;
  late final String? imageVal;
  late final bool addExam;
  late final int? examId;

  final Rx<FormDataError> formError = FormDataError().obs;

  final TextEditingController nameExamCotroller = TextEditingController();

  final List<Map<String, dynamic>> listIsPublic = [
    {
      'title': 'Công khai',
      'value': 1,
    },
    {
      'title': 'Không công khai',
      'value': 1,
    }
  ];

  List<int> listHashtagSelect = <int>[];
  final Rx<File?> selectedImage = Rx<File?>(null);

  late RxString dropdownMascotVal;
  late RxString dropdownIsPublicVal;

  late int mascotId;
  late int isPublicId;

  final Rx<ApiResponse<List<MascotItem>>> linhVatRes =
      ApiResponse<List<MascotItem>>.loading().obs;
  final Rx<ApiResponse<bool>> addExamRes =
      ApiResponse<bool>.completed(null).obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  String urlImage = '';

  // late

  void setSelectImage(File value) {
    selectedImage.value = value;
  }

  void setLinhVatRes(ApiResponse<List<MascotItem>> res) {
    linhVatRes.value = res;
  }

  void setAddExamtRes(ApiResponse<bool> res) {
    addExamRes.value = res;
  }

  void setUploadImageRes(ApiResponse<bool> res) {
    uploadImageRes.value = res;
  }

  Future<void> _fetchDataAddExam(RequestData req) async {
    try {
      await _accessServerRepository.postData(req.toMap());

      setAddExamtRes(ApiResponse.completed(true));
      Get.offAllNamed(Routes.exportExamSusscess, arguments: {
        'examId': examId,
        'type': '',
      });
    } catch (e, s) {
      s.printError();
      setAddExamtRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoadAddExam(
    String title,
    String des,
  ) async {
    setAddExamtRes(ApiResponse.loading());
    if (selectedImage.value != null) {
      await handleUploadImage();
    }

    Map data = {
      'exam_id': examId ?? '',
      'mascot_id': mascotId,
      'title': title,
      'description': des,
      'image': imageVal ?? urlImage,
      'exam_type': examType,
      'list_question': listQusestionId,
      'hashtag_list': listHashtagSelect,
      'is_public': isPublicId,
    };

    RequestData resquestData = RequestData(
      query: addExam ? 'exam_add' : 'exam_edit',
      data: json.encode(data),
    );

    await _fetchDataAddExam(resquestData);
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<MascotItem> data =
          res.map((item) => MascotItem.fromMap(item)).toList();

      listMascot.addAll(data);
      dropdownMascotVal = listMascot.first.title.obs;
      mascotId = listMascot.first.id;

      setLinhVatRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setLinhVatRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoad() async {
    await TokensTable.getToken().then((value) async {
      if (value == null) return;

      Map data = {
        'key': '',
        'page': 1,
        'user_id': value.user_id,
        'channel_id': '',
      };

      RequestData resquestData = RequestData(
        query: 'mascot_list',
        data: json.encode(data),
      );

      _fetchData(resquestData);
    });
  }

  Future<void> _uploadData(UploadFileModel req) async {
    setUploadImageRes(ApiResponse.loading());
    try {
      final String res = await _accessServerRepository.uploadFile(req);

      urlImage = '${Configs.domain}/$res';

      setUploadImageRes(ApiResponse.completed(true));
    } catch (e, s) {
      s.printError();
      setUploadImageRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleUploadImage() async {
    if (selectedImage.value == null) return;

    Map<String, dynamic> data = {
      //
    };

    RequestData requestData = RequestData(
      query: 'upload_image',
      // token_login: value
      data: json.encode(data),
    );

    UploadFileModel uploadFileModel = UploadFileModel(
      requestData: requestData.toMap(),
      file: selectedImage.value!,
    );

    _uploadData(uploadFileModel);
  }

  void onChangeSelectMascot(String value, int id) {
    dropdownMascotVal.value = value;
    mascotId = id;
  }

  void onChangeSelectIsPublic(String value, int id) {
    dropdownIsPublicVal.value = value;
    isPublicId = id;
  }

  void onChangeSelectHashtag(List<int> value) {
    listHashtagSelect = [];
    listHashtagSelect.addAll(value);
  }

  Future<void> handleSubmit(
    String title,
    String des,
  ) async {
    if (title.isEmpty) {
      formError.value.name = 'Vui lòng nhập tên bộ đề';
    } else {
      formError.value.name = '';
    }

    formError.refresh();
    if (formError.value == FormDataError()) {
      await handleLoadAddExam(title, des);
    }
    // Get.toNamed(Routes.exportExamSusscess);
  }

  Future<void> initData() async {
    await handleLoad();

    listQusestionId = Get.arguments['listQuestionId'];
    examType = Get.arguments['examType'];
    sampleExamTitle = Get.arguments['sampleExamTitle'];
    imageVal = Get.arguments['imageVal'];
    addExam = Get.arguments['addExam'] ?? false;
    examId = Get.arguments['examId'];

    nameExamCotroller.text = sampleExamTitle;

    String dropdownVal = listIsPublic.first['title'];
    dropdownIsPublicVal = dropdownVal.obs;
    isPublicId = listIsPublic.first['value'];

    listHashtag.addAll(_appDataController.appDataRes.value.data!.hashtag);
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}

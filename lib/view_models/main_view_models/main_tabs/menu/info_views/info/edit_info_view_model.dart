import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tai_khoan_ca_nhan_view_model.dart';

class EditInfoViewModel extends GetxController {
  late final String title;
  late final EditType editType;
  final TextEditingController textEditControllerValue = TextEditingController();
  final TaiKhoanCaNhanViewModel _taiKhoanCaNhanViewModel =
      Get.find<TaiKhoanCaNhanViewModel>();

  void hanleSubmit() {
    switch (editType) {
      case EditType.fullname:
        _taiKhoanCaNhanViewModel.fullname.value = textEditControllerValue.text;
        break;
      case EditType.channleTitle:
        _taiKhoanCaNhanViewModel.channelTitle.value =
            textEditControllerValue.text;
        break;
      case EditType.job:
        _taiKhoanCaNhanViewModel.job.value = textEditControllerValue.text;
        break;
      case EditType.archieve:
        _taiKhoanCaNhanViewModel.archieve.value = textEditControllerValue.text;
        break;
      case EditType.description:
        _taiKhoanCaNhanViewModel.description.value =
            textEditControllerValue.text;
        break;
      default:
      //
    }
    Get.back();
  }

  @override
  void onInit() {
    final String? paramValue = Get.arguments['editValue'];
    final String? paramValueTitle = Get.arguments['editTitle'];
    final EditType? paramValueEditType = Get.arguments['editType'];
    if (paramValue != null &&
        paramValueTitle != null &&
        paramValueEditType != null) {
      textEditControllerValue.text = paramValue;
      title = paramValueTitle;
      editType = paramValueEditType;
    }
    super.onInit();
  }
}

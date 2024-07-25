import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../database/tables/search_history_table.dart';
import '../../../models/Exam/search_history.dart';
import '../../controllers/app_data_controller.dart';

class SearchViewViewModel extends GetxController {
  final AppDataController _appDataController = Get.find<AppDataController>();
  late List<String> listData;

  final TextEditingController textSearchController = TextEditingController();
  FocusNode focus = FocusNode();

  final RxList<SearchHistory> listSearchHistory = <SearchHistory>[].obs;

  Future<void> initData() async {
    final List<SearchHistory>? listData = await SearchHistoryTable.getList();
    listSearchHistory.clear();
    if (listData != null) {
      listSearchHistory.addAll(listData);
    }
    listSearchHistory.refresh();
  }

  Future<void> insert() async {
    SearchHistory searchHistory =
        SearchHistory(content: textSearchController.text);
    // listSearchHistory.add(searchHistory);
    // listSearchHistory.refresh();

    await SearchHistoryTable.insert(searchHistory);
    await initData();
  }

  Future<void> delete(int id) async {
    // listSearchHistory.remove(searchHistory);

    await SearchHistoryTable.delete(id);
    await initData();
  }

  void handleDelete() {
    textSearchController.text = '';
    focus.requestFocus();
    Get.back();
  }

  // void handleBack() {
  //   focus.requestFocus();
  //   Get.back();
  // }

  void onSearch() {
    focus.requestFocus();
    Get.back();
  }

  void handleOnPressSearch(String value) {
    textSearchController.text = value;
    Get.toNamed(Routes.resultSearch, arguments: {
      'searchValue': value,
    });
  }

  @override
  void onInit() {
    String? searchValue = Get.arguments['searchValue'];
    if (searchValue != null) {
      textSearchController.text = searchValue;
    }
    initData();
    listData = _appDataController.appDataRes.value.data!.trending;
    super.onInit();
  }

  @override
  void onClose() {
    textSearchController.dispose();
    // focus.dispose();

    super.onClose();
  }
}

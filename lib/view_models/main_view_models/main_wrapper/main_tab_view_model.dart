import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainTabViewModel extends GetxController {
  RxBool showMenu = false.obs;

  PageController pageController = PageController(initialPage: 0);
  RxInt currentPage = 0.obs;

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void handleShowMenu() {
    showMenu.value = !showMenu.value;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

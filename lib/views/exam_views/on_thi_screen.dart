import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goup_app/views/widgets/avatar_container.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/routes.dart';
import '../../models/Exam/question_model.dart';
import '../../services/response/api_status.dart';
import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';
import '../../view_models/controllers/user_controller.dart';
import '../../view_models/tab_view_models/channel_tabs/on_thi_view_model.dart';
// import '../widgets/comment_tree.dart';
import '../widgets/comment_tree_2.dart';
import '../widgets/exam/on_thi_container.dart';
import '../widgets/show_dialog_error.dart';

class OnThiScreen extends StatelessWidget {
  OnThiScreen({super.key});
  final OnThiViewModel _onThiViewModel = Get.put(OnThiViewModel());
  final UserController _userController = Get.find<UserController>();

  Color handleAnswerColor(AnswerStatus status) {
    if (status == AnswerStatus.success) {
      return const Color(0xFF2EE56B);
    } else if (status == AnswerStatus.fail) {
      return const Color(0xFFFF3434);
    } else {
      return const Color(0xFFF0EBF5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Ôn thi',
            style: TextThemes.text18_500,
          ),
          leading: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Get.offAllNamed(Routes.successExam),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFF6E47),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                elevation: 0,
              ),
              child: Text(
                'Nộp bài',
                style: TextThemes.text12_600,
              ),
            ),
            const SizedBox(width: 16),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Color(0xFF353542),
              height: 1,
            ),
          )),
      body: Obx(() {
        if (_onThiViewModel.examHistoryAddRes.value.status == Status.error) {
          showDialogError(
              error: _onThiViewModel.examHistoryAddRes.value.message!);
        }

        if (_onThiViewModel.examHistoryAddRes.value.status ==
            Status.completed) {
          return screen();
        }
        return const Center(
          child: CircularProgressIndicator(
            color: ColorApp.colorOrange,
          ),
        );
      }),
    );
  }

  Widget screen() {
    double sizeWidth = Get.width;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: _onThiViewModel.listDataQuestion
                        .mapIndexed(
                          (index, item) => Obx(
                            () => GestureDetector(
                              onTap: () => _onThiViewModel.hanleOnSelect(index),
                              child: Container(
                                width: 40,
                                margin: const EdgeInsets.only(right: 16),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: handleAnswerColor(item.status.value),
                                  ),
                                ),
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: handleAnswerColor(item.status.value),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/arrow-down-2.svg'),
            )
          ],
        ),
        const SizedBox(height: 12),
        Container(
          color: const Color(0xFF353542),
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => RichText(
                    text: TextSpan(
                      text: 'Câu: ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '${_onThiViewModel.isSelect.value + 1}',
                          style: const TextStyle(
                            color: Color(0xFFFF6E47),
                          ),
                          children: [
                            const TextSpan(text: '/'),
                            TextSpan(
                              text:
                                  '${_onThiViewModel.listDataQuestion.length}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => onShowComment(),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/comment.svg'),
                      const SizedBox(width: 4),
                      Obx(
                        () => Text(
                          '(${_onThiViewModel.totalComment.value})',
                          style: TextThemes.text16_500,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
        // const SizedBox(height: 6),
        Expanded(
          child: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              int index = _onThiViewModel.isSelect.value;
              if (details.primaryVelocity! > sizeWidth * 0.2) {
                // User swiped Left
                _onThiViewModel.hanleOnSelect(index - 1);
              } else if (details.primaryVelocity! < sizeWidth * 0.2) {
                // User swiped Right
                _onThiViewModel.hanleOnSelect(index + 1);
              }
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ..._onThiViewModel.listDataQuestion.mapIndexed(
                          (index, item) => Obx(
                            () => Visibility(
                              visible: index == _onThiViewModel.isSelect.value,
                              child: OnThiContainer(question: item),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: _onThiViewModel.showElement.value,
                    child: Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: Get.height * 0.1),
                          child: SizedBox(
                            width: Get.width * 0.4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                    'assets/images/right-to-left-2.gif'),
                                const SizedBox(height: 6),
                                Text(
                                  'Vuốt sang trái để chuyển tiếp câu hỏi',
                                  textAlign: TextAlign.center,
                                  style: TextThemes.text14_500.copyWith(
                                    color: const Color(0xFFE0E0E6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onShowComment() async {
    _onThiViewModel.handleLoadComment();

    final TextEditingController commentController = TextEditingController();

    final RxString userRefer = ''.obs;
    int parentId = -1;
    int userReferId = -1;

    final Rx<File?> selectedImage = Rx<File?>(null);

    void setSelectImage(File? value) {
      selectedImage.value = value;
    }

    void setUserRefer(
      String userReferVal,
      int parentIdVal,
      int userReferIdVal,
    ) {
      userRefer.value = userReferVal;
      parentId = parentIdVal;
      userReferId = userReferIdVal;
    }

    Future<void> pickImageFromGallery() async {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage == null) return;
      // printInfo(info: returnedImage.path);
      setSelectImage(File(returnedImage.path));
    }

    return Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color(0xFF202025),
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            SizedBox(width: Get.width),
            const SizedBox(height: 20),
            Obx(
              () => Text(
                '${_onThiViewModel.totalComment.value} bình luận',
                style: TextThemes.text15_500,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (_onThiViewModel.commentRes.value.status == Status.error) {
                  showDialogError(
                      error: _onThiViewModel.commentRes.value.message!);
                }

                if (_onThiViewModel.commentRes.value.status ==
                    Status.completed) {
                  return ListView.builder(
                    itemCount: _onThiViewModel.listComment.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (BuildContext context, int index) {
                      return CommentTree2(
                        comment: _onThiViewModel.listComment[index],
                        eventRefer: setUserRefer,
                        eventEdit: _onThiViewModel.handleLoadEditComment,
                        eventDelete: _onThiViewModel.handleLoadDeleteComment,
                        eventChangeStatus:
                            _onThiViewModel.handleLoadUpdateStatusComment,
                        eventAddFavorite:
                            _onThiViewModel.handleLoadAddFavoriteComment,
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorApp.colorOrange,
                  ),
                );
              }),
            ),
            const Divider(
              height: 1,
              color: Color(0xFF353542),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: userRefer.value.isNotEmpty,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Đang phản hồi ',
                                  style: TextThemes.text12_400.copyWith(
                                    color: const Color(0xFFE0E0E6),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: userRefer.value,
                                      style: TextThemes.text12_600,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 3,
                                height: 3,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () => setUserRefer('', -1, -1),
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Hủy',
                                  style: TextThemes.text12_600.copyWith(
                                    color: const Color(0xFFA2A2B5),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        AvatarContainer(
                          radius: 44,
                          image: _userController.userRes.value.data!.image,
                          replaceImage: 'assets/images/avatar-1.png',
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xFF3F3F40),
                            ),
                            child: Row(
                              children: [
                                Visibility(
                                  visible: userRefer.value.isNotEmpty,
                                  child: Text(
                                    userRefer.value,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF0584FE),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: Get.height * 0.2,
                                    ),
                                    child: SingleChildScrollView(
                                      child: TextField(
                                        controller: commentController,
                                        onTapOutside: (event) => FocusManager
                                            .instance.primaryFocus
                                            ?.unfocus(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          isDense:
                                              true, // Cho chu can giua theo chieu doc
                                          hintText: userRefer.value.isEmpty
                                              ? 'Viết bình luận...'
                                              : null,
                                          hintStyle: const TextStyle(
                                            color: Color(0xFFC7C9D9),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.01,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: selectedImage.value == null,
                                    child: IconButton(
                                      onPressed: () async =>
                                          await pickImageFromGallery(),
                                      style: IconButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      icon: SvgPicture.asset(
                                          'assets/icons/camera.svg'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () async {
                            if (commentController.text.isNotEmpty) {
                              await _onThiViewModel.handleLoadAddComment(
                                content: commentController.text,
                                prarentId: parentId,
                                userRefer: userReferId,
                                file: selectedImage.value,
                              );
                              commentController.clear();
                              setUserRefer('', -1, -1);
                              setSelectImage(null);
                            } else {
                              //
                            }
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: SvgPicture.asset('assets/icons/send-2.svg'),
                        ),
                      ],
                    ),
                    selectedImage.value == null
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    selectedImage.value!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                IconButton(
                                  onPressed: () => setSelectImage(null),
                                  style: IconButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    elevation: 0,
                                  ),
                                  icon: SvgPicture.asset(
                                      'assets/icons/remove-image.svg'),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

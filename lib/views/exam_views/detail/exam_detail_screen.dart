// import 'dart:io';
import 'dart:io';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/routes.dart';
import '../../../models/Exam/comment.dart';
import '../../../models/Exam/exam_detail_response.dart';
import '../../../models/Exam/question.dart';
import '../../../models/home_models/hashtag.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/controllers/user_controller.dart';
import '../../../view_models/tab_view_models/channel_tabs/exam_detail_view_model.dart';
import '../../widgets/avatar_container.dart';
import '../../widgets/button_primary.dart';
// import '../../widgets/comment_tree_2.dart';
import '../../widgets/comment_tree_2.dart';
import '../../widgets/image_container.dart';
// import '../../widgets/input_comment.dart';
import '../../widgets/show_dialog_error.dart';

class Dropdown {
  final String key;
  final int value;

  Dropdown({required this.key, required this.value});
}

class ExamDetailScreen extends StatelessWidget {
  ExamDetailScreen({super.key});
  final ExamDetailViewModel _examDetailViewModel =
      Get.put(ExamDetailViewModel());
  final UserController _userController = Get.find<UserController>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.colorBlack4,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Chi tiết đề thi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      if (_examDetailViewModel.examDetailRes.value.status ==
                          Status.error) {
                        showDialogError(
                          error:
                              _examDetailViewModel.examDetailRes.value.message!,
                        );
                      }

                      if (_examDetailViewModel.donateRes.value.status ==
                          Status.error) {
                        showDialogError(
                          error: _examDetailViewModel.donateRes.value.message!,
                        );
                      }

                      if (_examDetailViewModel.changeFavoriteRes.value.status ==
                          Status.error) {
                        showDialogError(
                          error: _examDetailViewModel
                              .changeFavoriteRes.value.message!,
                        );
                      }

                      if (_examDetailViewModel.examDetailRes.value.status ==
                          Status.completed) {
                        return examDetail(
                            _examDetailViewModel.examDetailRes.value.data!);
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorApp.colorOrange,
                        ),
                      );
                    }),
                    Obx(() {
                      if (_examDetailViewModel.questionRes.value.status ==
                          Status.error) {
                        showDialogError(
                          error:
                              _examDetailViewModel.questionRes.value.message!,
                        );
                      }

                      if (_examDetailViewModel.questionRes.value.status ==
                          Status.completed) {
                        return exam();
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorApp.colorOrange,
                        ),
                      );
                    }),
                    Obx(() {
                      if (_examDetailViewModel.commentRes.value.status ==
                          Status.error) {
                        showDialogError(
                          error: _examDetailViewModel.commentRes.value.message!,
                        );
                      }

                      if (_examDetailViewModel.commentRes.value.status ==
                              Status.completed &&
                          _examDetailViewModel.questionRes.value.status ==
                              Status.completed) {
                        // return comment(_examDetailViewModel.listDataComment);
                        return listDataComment();
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorApp.colorOrange,
                        ),
                      );
                    }),
                    // listDataComment(),
                    // comment(),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF000000),
              child: Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: _examDetailViewModel
                                  .examDetailRes.value.data?.user_info.id ==
                              _userController.userRes.value.data?.id
                          ? button(
                              icon: 'assets/icons/edit_exam.svg',
                              title: 'Chỉnh sửa đề',
                              backgroundColor: const Color(0xFF312E2E),
                              textColor: Colors.white,
                              event: () => Get.toNamed(Routes.editExam),
                            )
                          : button(
                              icon: 'assets/icons/copy.svg',
                              title: 'Sao chép đề',
                              backgroundColor: const Color(0xFF312E2E),
                              textColor: Colors.white,
                              event: () => onShowCopy(
                                examDetail: _examDetailViewModel
                                    .examDetailRes.value.data!,
                                linkExam: 'https://referral.goupeeapp...',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: button(
                      icon: 'assets/icons/edit.svg',
                      title: 'Bắt đầu thi',
                      backgroundColor: const Color(0xFFFF6E47),
                      textColor: Colors.white,
                      event: () {
                        if (_userController.userRes.value.data?.is_login !=
                            null) {
                          onSelectExam(context: context);
                        } else {
                          showDialogError(
                            error:
                                'Bạn cần đăng nhập để thực hiện chức năng này',
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleShow() {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202025),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            style: IconButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/close.svg',
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset('assets/icons/linh-vat-slacking.svg'),
                      const SizedBox(height: 12),
                      const Text(
                        'Bạn đang làm dở .Bạn có muốn làm tiếp không?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFE0E0E6),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Làm lại từ đầu',
                              background: const Color(0xFF312E2E),
                              event: () =>
                                  Get.offNamed(Routes.thiThu, arguments: {
                                'examHistoryId': _examDetailViewModel
                                    .examDetailRes.value.data!.has_history,
                                'examId': _examDetailViewModel.examId,
                                'totalQuestion': 0,
                              }),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Làm tiếp',
                              event: () =>
                                  Get.offNamed(Routes.thiThu, arguments: {
                                'examHistoryId': _examDetailViewModel
                                    .examDetailRes.value.data!.has_history,
                                'examId': _examDetailViewModel.examId,
                                'totalQuestion': 0,
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Widget comment(List<Comment> listDataComment) {
    // final TextEditingController commentController = TextEditingController();

    // final RxString userRefer = ''.obs;
    // int parentId = -1;
    // int userReferId = -1;

    // final Rx<File?> selectedImage = Rx<File?>(null);

    // void setSelectImage(File? value) {
    //   selectedImage.value = value;
    // }

    // void setUserRefer(
    //   String userReferVal,
    //   int parentIdVal,
    //   int userReferIdVal,
    // ) {
    //   userRefer.value = userReferVal;
    //   parentId = parentIdVal;
    //   userReferId = userReferIdVal;
    // }

    // Future<void> pickImageFromGallery() async {
    //   final returnedImage =
    //       await ImagePicker().pickImage(source: ImageSource.gallery);
    //   if (returnedImage == null) return;
    //   // printInfo(info: returnedImage.path);
    //   setSelectImage(File(returnedImage.path));
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xFF353542),
          ),
          const SizedBox(height: 16),
          Text(
            '${_examDetailViewModel.examDetailRes.value.data!.exam_detail.comment_question_total ?? 0} bình luận',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          ListView.builder(
            itemCount: _examDetailViewModel.listDataComment.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: commentContainer(
                    _examDetailViewModel.listDataComment[index]),
                //   CommentTree2(
                // comment: _examDetailViewModel.listDataComment[index],
                // eventRefer: setUserRefer,
                // ),
              );
            },
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: inputComment(
                isPhanHoi: '',
                indexQuestion: _examDetailViewModel
                    .selectIndexQuestion.value.questionIndex,
                // event: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listDataComment() {
    final TextEditingController commentController = TextEditingController();

    final RxString userRefer = ''.obs;
    int parentId = -1;
    int userReferId = -1;

    int? indexQuestion =
        _examDetailViewModel.selectIndexQuestion.value.questionIndex;

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xFF353542),
          ),

          const SizedBox(height: 16),
          Text(
            '${_examDetailViewModel.examDetailRes.value.data!.exam_detail.comment_question_total ?? 0} bình luận',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          ListView.builder(
            itemCount: _examDetailViewModel.listDataComment.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (BuildContext context, int index) {
              return CommentTree2(
                comment: _examDetailViewModel.listDataComment[index],
                eventRefer: setUserRefer,
                eventEdit: _examDetailViewModel.handleLoadEditComment,
                eventDelete: _examDetailViewModel.handleLoadDeleteComment,
                eventChangeStatus:
                    _examDetailViewModel.handleLoadUpdateStatusComment,
                eventAddFavorite:
                    _examDetailViewModel.handleLoadAddFavoriteComment,
              );
            },
          ),
          // Obx(
          //   () => Padding(
          //     padding: const EdgeInsets.only(bottom: 16),
          //     child: inputComment(
          //       isPhanHoi: '',
          //       indexQuestion: _examDetailViewModel
          //           .selectIndexQuestion.value.questionIndex,
          //       // event: () {},
          //     ),
          //   ),
          // ),
          const Divider(
            height: 1,
            color: Color(0xFF353542),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                                visible: indexQuestion != -1,
                                child: Text(
                                  '#${indexQuestion + 1}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF83839C),
                                  ),
                                ),
                              ),
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
                            await _examDetailViewModel.handleLoadAddComment(
                              content: commentController.text,
                              prarentId: parentId,
                              userRefer: userReferId,
                              file: selectedImage.value,
                            );
                            commentController.clear();
                            setUserRefer('', -1, -1);
                            setSelectImage(null);
                            _examDetailViewModel
                                .setSelectIndexQuestion(SelectQuestion());
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
    );
  }

  Widget inputComment({
    required String isPhanHoi,
    int? indexQuestion,
    void Function()? event,
  }) {
    final TextEditingController commentController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 1,
          color: Color(0xFF353542),
        ),
        const SizedBox(height: 16),
        Visibility(
          visible: isPhanHoi.isNotEmpty,
          maintainSize: false,
          maintainAnimation: true,
          maintainState: true,
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Đang phản hồi ',
                  style: TextThemes.text12_400.copyWith(
                    color: const Color(0xFFE0E0E6),
                  ),
                  children: [
                    TextSpan(
                      text: isPhanHoi,
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
                onPressed: event,
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: 44,
                height: 44,
                child: Image.asset(
                  'assets/images/avatar-1.png',
                  fit: BoxFit.cover,
                ),
              ),
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
                      visible: indexQuestion != -1 && indexQuestion != null,
                      child: Text(
                        '#$indexQuestion',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF83839C),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isPhanHoi.isNotEmpty,
                      child: Text(
                        isPhanHoi,
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
                            onTapOutside: (event) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              isDense: true, // Cho chu can giua theo chieu doc
                              hintText: isPhanHoi.isEmpty
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
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: SvgPicture.asset('assets/icons/camera.svg'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () async {
                if (commentController.text.isNotEmpty) {
                  // await _examDetailViewModel
                  //     .handleLoadAddComment(commentController.text);
                  commentController.clear();
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
      ],
    );
  }

  Widget exam() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 1,
                color: Color(0xFF353542),
              ),
              const SizedBox(height: 16),
              Text(
                'Danh sách câu hỏi',
                style: TextThemes.text14_500,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 3,
          color: const Color(0xFFFF9055),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  border: Border.all(
                    width: 2,
                    color: const Color(0xFFFF9255),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/linh-vat-5.png'),
                    const SizedBox(width: 12),
                    const Flexible(
                      child: Text(
                        'Bạn đang ở chế độ xem trước, Bạn đang ở chế độ xem trước , hãy bắt đầu ôn thi ngay nhé',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF131313),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _examDetailViewModel.listDataQuestion.length,
            // itemCount: 3,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: cauHoi(
                  index: index + 1,
                  question: _examDetailViewModel.listDataQuestion[index],
                  event: () => _examDetailViewModel
                      .setSelectIndexQuestion(SelectQuestion(
                    questionIndex: index,
                    questionId: _examDetailViewModel.listDataQuestion[index].id,
                  )),
                ),
              );
            },
          ),
        ),
        TextButton(
          onPressed: () => _examDetailViewModel.addQuestion(3),
          style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Xem thêm',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset('assets/icons/xem-them.svg'),
            ],
          ),
        )
      ],
    );
  }

  Widget examDetail(ExamDetailResponse examDetailResponse) {
    int? isLogin = _userController.userRes.value.data?.is_login;
    return Column(
      children: [
        Stack(
          children: [
            ImageContainer(
              image: examDetailResponse.exam_detail.image,
              replaceImage: 'assets/images/exam-detail-1.png',
              height: Get.height * 0.62,
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 23,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      button1(
                        icon: _examDetailViewModel.isFavorite.value
                            ? 'assets/icons/heart-icon-5.svg'
                            : 'assets/icons/heart-icon-3.svg',
                        count:
                            _examDetailViewModel.totalFavorite.value.toString(),
                        event: () {
                          if (isLogin != null) {
                            _examDetailViewModel.handleLoadChangeFavorite();
                          }
                        },
                      ),
                      SizedBox(height: Get.height * 0.01),
                      button1(
                        icon: 'assets/icons/messages-icon-2.svg',
                        count: examDetailResponse.exam_detail.total_question
                            .toString(),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      _examDetailViewModel
                                  .examDetailRes.value.data?.user_info.id ==
                              _userController.userRes.value.data?.id
                          ? const SizedBox()
                          : button1(
                              icon: 'assets/icons/repeat.svg',
                              count: examDetailResponse.exam_detail.total_copies
                                  .toString(),
                            ),
                      SizedBox(height: Get.height * 0.01),
                      _examDetailViewModel
                                  .examDetailRes.value.data?.user_info.id ==
                              _userController.userRes.value.data?.id
                          ? const SizedBox()
                          : button1(
                              // icon: 'assets/icons/coin-icon.svg',
                              icon: 'assets/icons/coin-icon-2.png',
                              // count: examDetailResponse.exam_detail.total_gpoints.toString(),
                              count: 'Donate',
                              iconType: true,
                              event: () {
                                if (isLogin != null) {
                                  _examDetailViewModel.handleLoadDonate();
                                }
                              },
                            ),
                      SizedBox(height: Get.height * 0.01),
                      button1(
                        icon: 'assets/icons/share.svg',
                        count: examDetailResponse.exam_detail.total_shares
                            .toString(),
                        event: () async {
                          // Uri uri = Uri.parse(
                          //     'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2Fvn%2Fimage-generator%2F&psig=AOvVaw07iBDNyHV36nbAIP3z78Bz&ust=1720236987558000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCPiYoab8jocDFQAAAAAdAAAAABAE');
                          // await Share.shareUri(uri);
                          await Share.share(
                            'Bài thi này',
                            subject: 'Đề thi',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned.fill(
            //   child: Padding(
            //     padding: const EdgeInsets.all(25),
            //     child: Align(
            //       alignment: Alignment.bottomLeft,
            //       child: Text(
            //         examDetailResponse.exam_detail.title,
            //         style: const TextStyle(
            //           fontSize: 37,
            //           fontWeight: FontWeight.w600,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF201E1F),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _scrollController.animateTo(
                          Get.height * 0.88,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/down-icon.svg',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                examDetailResponse.exam_detail.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/star.svg'),
                      const SizedBox(width: 5),
                      RichText(
                        text: TextSpan(
                          text: '${examDetailResponse.exam_detail.star_avg}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          children: [
                            const TextSpan(text: ' / '),
                            const TextSpan(text: '5'),
                            const TextSpan(
                              text: ' | ',
                              style: TextStyle(
                                color: Color(0xFFA2A2B5),
                              ),
                            ),
                            TextSpan(
                                text:
                                    '${examDetailResponse.exam_detail.total_rates}'),
                            const TextSpan(text: ' đánh giá'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => onShowExamPreview(examDetailResponse),
                    style: IconButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: SvgPicture.asset('assets/icons/quesion-2.svg'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  ...examDetailResponse.hashtags.map((hashtag) {
                    final Map<String, int> color =
                        _examDetailViewModel.colorHashtag[Random()
                            .nextInt(_examDetailViewModel.colorHashtag.length)];
                    return hashtagBtn(
                      hashtag: hashtag,
                      backgroundColor: Color(color['backgroundColor']!),
                      textColor: Color(color['textColor']!),
                      event: () {},
                    );
                  }),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  AvatarContainer(
                    radius: 32,
                    image: examDetailResponse.user_info.image,
                    replaceImage: 'assets/images/avatar-2.png',
                  ),
                  const SizedBox(width: 8),
                  Text(
                    examDetailResponse.user_info.fullname,
                    style: TextThemes.text14_400,
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rowInfo(
                    image: 'assets/icons/quesion.svg',
                    title:
                        '${examDetailResponse.exam_detail.list_question.length} câu hỏi',
                  ),
                  rowInfo(
                    image: 'assets/icons/edit.svg',
                    title:
                        '${examDetailResponse.exam_detail.total_attempts} lượt thi',
                  ),
                  rowInfo(
                    image: 'assets/icons/clock-icon.svg',
                    title: examDetailResponse.exam_detail.created,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  void onSelectExam({required BuildContext context}) {
    final RxBool isOnThi = true.obs;

    void onSelectCheDo(bool value) {
      isOnThi.value = value;
    }

    final List<Dropdown> dropdownSoCauHoi = <Dropdown>[];

    final int length = _examDetailViewModel.listQuestionVal.length;

    final int lengthQuestionVal = (length / 10).ceil();

    // Số câu hỏi > 10 thì mới làm tiếp
    if (lengthQuestionVal > 0) {
      for (int i = 1; i < lengthQuestionVal; i++) {
        dropdownSoCauHoi
            .add(Dropdown(key: (i * 10).toString(), value: (i * 10)));
      }
    }

    final Rx<Dropdown> dropdownValue =
        Dropdown(key: 'Tất cả', value: length).obs;

    void onChangSelect(Dropdown? value) {
      if (value == null) return;
      dropdownValue.value = value;
    }

    dropdownSoCauHoi.add(dropdownValue.value);

    Get.dialog(
      barrierDismissible: true,
      Center(
        child: Container(
          width: Get.width * 0.8,
          decoration: const BoxDecoration(
            color: Color(0xFF202025),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chọn chế độ thi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              cheDoContainer(
                                title: 'Ôn thi',
                                image: 'assets/images/on-thi.png',
                                isSelect: isOnThi.value,
                                event: () => onSelectCheDo(true),
                              ),
                              const SizedBox(width: 16),
                              cheDoContainer(
                                title: 'Thi thử',
                                image: 'assets/images/thi-thu.png',
                                isSelect: isOnThi.value == false,
                                event: () => onSelectCheDo(false),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          isOnThi.value
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    rowCheDo(
                                        title:
                                            'Không giới hạn thời gian làm đề thi'),
                                    const SizedBox(height: 12),
                                    rowCheDo(title: 'Hiển thị ngay đáp án'),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    rowCheDo(
                                        title:
                                            'Thời gian làm bài và điểm số sẽ được xét rank trên bảng xếp hạng'),
                                    const SizedBox(height: 12),
                                    rowCheDo(
                                        title: 'Không hiển thị ngay đáp án'),
                                    const SizedBox(height: 12),
                                    rowCheDo(
                                        title:
                                            'Kết quả sẽ được hiển thị ngay khi bạn nộp bài'),
                                    const SizedBox(height: 20),
                                    Image.asset('assets/images/line.png'),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/setting-2.svg'),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Cài đặt đề thi',
                                          style: TextThemes.text14_600,
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Số câu hỏi lấy ra ngẫu nhiên',
                                      style: TextThemes.text12_500,
                                    ),
                                    const SizedBox(height: 4),
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: Obx(
                                          () => DropdownButton2<Dropdown>(
                                            items: <DropdownMenuItem<Dropdown>>[
                                              ...dropdownSoCauHoi.map((item) =>
                                                  DropdownMenuItem<Dropdown>(
                                                    value: item,
                                                    child: Text(
                                                      item.key,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                            value: dropdownValue.value,
                                            onChanged: (Dropdown? newValue) =>
                                                onChangSelect(newValue),
                                            customButton: Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  width: 1,
                                                  color:
                                                      const Color(0xFF636363),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      dropdownValue.value.key,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  SvgPicture.asset(
                                                      'assets/icons/arrow-down.svg'),
                                                ],
                                              ),
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              maxHeight: Get.height * 0.2,
                                              // width: Get.width * 0.8,
                                              padding: EdgeInsets.zero,
                                              elevation: 0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF3F3F40),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              offset: const Offset(0, -10),
                                              scrollbarTheme:
                                                  ScrollbarThemeData(
                                                radius:
                                                    const Radius.circular(40),
                                                thickness:
                                                    WidgetStateProperty.all(3),
                                                thumbVisibility:
                                                    WidgetStateProperty.all(
                                                        true),
                                                thumbColor:
                                                    WidgetStateProperty.all(
                                                        Colors.white),
                                              ),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                // vertical: 8,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tối đa $length câu',
                                      style: TextThemes.text12_500.copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Obx(
                                      () => RichText(
                                        text: TextSpan(
                                          text: 'Thời gian làm đề tương ứng: ',
                                          style: TextThemes.text12_500,
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${dropdownValue.value.value * 2} phút',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(height: 12),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(
                                    //       width: 20,
                                    //       height: 20,
                                    //       child: Checkbox(
                                    //         value: _examDetailViewModel
                                    //             .isXemDapAn.value,
                                    //         materialTapTargetSize:
                                    //             MaterialTapTargetSize.shrinkWrap,
                                    //         shape: RoundedRectangleBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(3),
                                    //         ),
                                    //         activeColor: const Color(0xFF3EC65C),
                                    //         side: const BorderSide(
                                    //           color: Color(0xFF83839C),
                                    //           width: 1.5,
                                    //         ),
                                    //         onChanged: (bool? value) =>
                                    //             _examDetailViewModel
                                    //                 .onXemDapAn(value),
                                    //       ),
                                    //     ),
                                    //     const SizedBox(width: 8),
                                    //     Text(
                                    //       'Xem chi tiết đáp án sau khi nộp bài',
                                    //       style: TextThemes.text12_500,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonPrimary(
                      title: 'Xác nhận vào thi',
                      event: () {
                        if (isOnThi.value) {
                          Get.offNamed(Routes.onThi);
                        } else if (_examDetailViewModel
                                .examDetailRes.value.data!.has_history ==
                            null) {
                          Get.offNamed(
                            Routes.thiThu,
                            arguments: {
                              'examHistoryId': 0,
                              'examId': _examDetailViewModel.examId,
                              'totalQuestion': dropdownValue.value.value,
                            },
                          );
                        } else {
                          handleShow();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget rowCheDo({required String title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/icons/success.svg'),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            title,
            style: TextThemes.text14_400.copyWith(
              color: const Color(0xFFE0E0E6),
            ),
          ),
        )
      ],
    );
  }

  Widget cheDoContainer({
    required String title,
    required String image,
    required bool isSelect,
    void Function()? event,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelect ? Colors.white : const Color(0xFFbbbbbb),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2.5,
            color: isSelect
                ? const Color(0xFFFF6E47)
                : const Color(0xFFB8B8B8).withOpacity(0.3),
          ),
        ),
        child: InkWell(
          onTap: event,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextThemes.text14_600.copyWith(
                  color: isSelect
                      ? const Color(0xFFFF6E47)
                      : const Color(0xFF4E4E61),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget commentContainer(Comment comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvatarContainer(
          radius: 40,
          image: comment.user_image,
          replaceImage: 'assets/images/avatar-1.png',
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF3F3F40),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.user_fullname,
                      style: TextThemes.text14_600,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      comment.content,
                      style: TextThemes.text12_400.copyWith(
                        color: const Color(0xFFE0E0E6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  button3(title: comment.created),
                  button3(title: 'Thích', event: () {}),
                  button3(title: 'Phản hồi', event: () {}),
                  // button3(title: 'Tặng G', event: () {}),
                  button3(
                      title: '${comment.favourite_points}',
                      icon: 'assets/icons/heart-icon.svg'),
                  button3(
                    title: '${comment.g_points}',
                    isSvg: false,
                    // icon: 'assets/icons/coin-icon.svg',
                    icon: 'assets/icons/coin-icon.png',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget button3({
    required String title,
    String? icon,
    bool isSvg = true,
    void Function()? event,
  }) {
    return TextButton(
      onPressed: event,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8F90A6),
            ),
          ),
          (icon != null)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 4),
                    isSvg
                        ? SvgPicture.asset(icon, height: 14)
                        : Image.asset(icon, height: 14),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget cauHoi({
    required int index,
    required Question question,
    void Function()? event,
  }) {
    final RxBool isShow = false.obs;

    String content = r"""Câu index. quest""";
    content = content.replaceAll("index", index.toString());
    content = content.replaceAll("quest", question.content);

    return GestureDetector(
      onTap: () => isShow.value = !isShow.value,
      child: Stack(
        children: [
          Column(
            children: [
              TeXView(
                child: TeXViewDocument(
                  content,
                  style: TeXViewStyle(
                    contentColor: Colors.white,
                    fontStyle: TeXViewFontStyle(
                      fontSize: 14,
                      fontWeight: TeXViewFontWeight.w600,
                    ),
                  ),
                ),
              ),
              ...question.images.map(
                (image) => ImageContainer(
                  image: image,
                  height: Get.height * 0.2,
                  replaceImage: '',
                ),
              ),
              TeXView(
                child: TeXViewColumn(
                  children: [
                    ...question.quest.entries.map(
                      (item) {
                        String quest = r"""key. value""";
                        quest = quest.replaceAll(
                            "key", getAnswerNumber(int.parse(item.key)));
                        quest = quest.replaceAll("value", item.value);
                        return TeXViewDocument(
                          quest,
                          style: TeXViewStyle(
                            contentColor: const Color(0xFFE0E0E6),
                            fontStyle: TeXViewFontStyle(
                              fontSize: 14,
                              fontWeight: TeXViewFontWeight.w400,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Obx(
            () => Visibility(
              visible: isShow.value,
              child: Positioned(
                top: 30,
                right: 0,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/arrow-wrapper-2.svg'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: TextButton(
                        onPressed: event,
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: const Color(0xFF3F3F40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Thêm Comment câu ${index.toString()}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFF0F3F9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button({
    required String icon,
    required String title,
    required Color backgroundColor,
    required Color textColor,
    void Function()? event,
  }) {
    return TextButton(
      onPressed: event,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget rowInfo({
    required String image,
    required String title,
  }) {
    return Row(
      children: [
        SvgPicture.asset(image),
        const SizedBox(width: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFFC1C1CD),
          ),
        )
      ],
    );
  }

  Widget button1({
    required String icon,
    required String count,
    void Function()? event,
    bool iconType = false,
  }) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF0E0E12).withOpacity(0.5),
          ),
          child: IconButton(
            onPressed: event,
            icon: iconType ? Image.asset(icon) : SvgPicture.asset(icon),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget hashtagBtn({
    required Hashtag hashtag,
    required Color backgroundColor,
    required Color textColor,
    void Function()? event,
  }) {
    return FilledButton(
      onPressed: event,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        hashtag.title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
    );
  }

  void onShowCopy({
    required ExamDetailResponse examDetail,
    required String linkExam,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Container(
          width: Get.width * 0.8,
          decoration: const BoxDecoration(
            color: Color(0xFF202025),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        examDetail.exam_detail.title,
                        style: TextThemes.text16_600,
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/close.svg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SvgPicture.asset(
                    'assets/icons/qr.svg',
                    width: Get.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  rowInfoCopy(
                    title: 'ID user',
                    value: '${examDetail.user_info.id}',
                  ),
                  const SizedBox(height: 16),
                  rowInfoCopy(
                    title: 'Link bài thi',
                    value: linkExam,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: button4(
                          title: 'Tải xuống',
                          icon: 'assets/icons/download-2.svg',
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 18,
                        color: const Color(0xFF83839C),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: button4(
                            title: 'Chia sẻ',
                            icon: 'assets/icons/share-2.svg',
                            event: () async {
                              // Uri uri = Uri.parse(
                              //     'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixlr.com%2Fvn%2Fimage-generator%2F&psig=AOvVaw07iBDNyHV36nbAIP3z78Bz&ust=1720236987558000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCPiYoab8jocDFQAAAAAdAAAAABAE');
                              // await Share.shareUri(uri);
                              await Share.share(
                                'Bài thi này',
                                subject: 'Đề thi',
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button4({
    required String title,
    required String icon,
    void Function()? event,
  }) {
    return TextButton(
      onPressed: event,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF6E47),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowInfoCopy({
    required String title,
    required String value,
    void Function()? event,
  }) {
    return Row(
      children: [
        SizedBox(
          width: Get.width * 0.18,
          child: Text(
            title,
            style: TextThemes.text12_400,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xFF353535),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: TextThemes.text14_400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 14),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: value));
                    // Get.snackbar(
                    //   '',
                    //   'Sao chép thành công',
                    //   // snackPosition: SnackPosition.BOTTOM,
                    // );
                  },
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: SvgPicture.asset('assets/icons/copy-2.svg'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void onShowExamPreview(ExamDetailResponse examDetailResponse) {
    Get.dialog(
      barrierDismissible: false,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202025),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            style: IconButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/close.svg',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Bộ đề gồm:',
                        style: TextThemes.text14_400,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/quesion.svg'),
                          const SizedBox(width: 4),
                          RichText(
                            text: TextSpan(
                              text:
                                  '${examDetailResponse.exam_detail.list_question.length}',
                              style: TextThemes.text14_400.copyWith(
                                color: const Color(0xFFC1C1CD),
                              ),
                              children: const [TextSpan(text: 'câu hỏi')],
                            ),
                          ),
                          const SizedBox(width: 24),
                          SvgPicture.asset('assets/icons/clock-icon.svg'),
                          const SizedBox(width: 4),
                          Text(
                            examDetailResponse.exam_detail.created,
                            style: TextThemes.text14_400.copyWith(
                              color: const Color(0xFFC1C1CD),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Thuộc linh vật ',
                            style: TextThemes.text14_400,
                          ),
                          InkWell(
                            child: Text(
                              '#${examDetailResponse.mascot_info.id}',
                              style: TextThemes.text14_400.copyWith(
                                color: const Color(0xFF0584FE),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        examDetailResponse.user_info.description ?? '',
                        style: TextThemes.text14_400,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          AvatarContainer(
                            radius: 40,
                            image: examDetailResponse.user_info.image,
                            replaceImage: 'assets/images/avatar-6.png',
                          ),
                          const SizedBox(width: 8),
                          RichText(
                            text: TextSpan(
                              text: 'Tác giả: ',
                              style: TextThemes.text14_500,
                              children: [
                                TextSpan(
                                    text:
                                        examDetailResponse.user_info.fullname),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        examDetailResponse.user_info.job_des ?? '',
                        style: TextThemes.text14_400.copyWith(
                          color: const Color(0xFFE0E0E6),
                        ),
                      ),
                      // const SizedBox(height: 12),
                      // rowContainerHH(
                      //   image: 'assets/icons/huy-hieu-1.svg',
                      //   title: 'Sáng kiến kinh nghiệm đạt loại B TP Hà Nội',
                      // ),
                      // const SizedBox(height: 12),
                      // rowContainerHH(
                      //   image: 'assets/icons/huy-hieu-2.svg',
                      //   title: 'Sáng kiến kinh nghiệm đạt loại B TP Hà Nội',
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowContainerHH({required String image, required String title}) {
    return Row(
      children: [
        SvgPicture.asset(image),
        const SizedBox(width: 4),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE0E0E6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../models/Exam/comment.dart';
import '../../utils/text_themes.dart';
import '../../view_models/controllers/user_controller.dart';
import 'avatar_container.dart';
import 'image_container.dart';

class CommentTree2 extends StatelessWidget {
  CommentTree2({
    super.key,
    required this.comment,
    required this.eventRefer,
    this.eventEdit,
    this.eventDelete,
    this.eventChangeStatus,
    this.eventAddFavorite,
  });

  final Comment comment;
  final void Function(String userReferVal, int parentIdVal, int userReferId)
      eventRefer;

  final void Function({
    required int commentId,
    required String content,
  })? eventEdit;

  final void Function(int commentId)? eventDelete;
  final void Function(int commentId)? eventChangeStatus;
  final void Function(int commentId)? eventAddFavorite;

  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        commentContainer(comment),
        const SizedBox(height: 16),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(left: Get.width * 0.1),
          itemCount: comment.child.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: commentContainer(comment.child[index]),
            );
          },
        ),
      ],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onLongPress: () {
                  if (_userController.userRes.value.data?.id ==
                      comment.user_id) {
                    onShowEdit();
                  }
                },
                child: Container(
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
              ),
              const SizedBox(height: 4),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  button3(title: comment.created),
                  button3(
                    title: 'Thích',
                    event: () {
                      if (eventAddFavorite != null) {
                        eventAddFavorite!(comment.id);
                      }
                    },
                  ),
                  button3(
                    title: 'Phản hồi',
                    event: () => eventRefer(
                      comment.user_fullname,
                      comment.id,
                      comment.user_id,
                    ),
                  ),
                  // button3(title: 'Tặng G', event: () {}),
                  button3(
                      title: '${comment.favourite_points}',
                      // title: '${totalFavorite.value}',
                      icon: 'assets/icons/heart-icon.svg'),

                  button3(
                    title: '${comment.g_points}',
                    isSvg: false,
                    // icon: 'assets/icons/coin-icon.svg',
                    icon: 'assets/icons/coin-icon.png',
                  ),
                ],
              ),
              Visibility(
                visible: comment.images != null && comment.images!.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ImageContainer(
                      image: comment.images,
                      height: 100,
                      widget: 100,
                      replaceImage: '',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> onShowEdit() async {
    return Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color(0xFF202025),
      Container(
        height: Get.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(width: Get.width),
            rowButton(
              icon: 'assets/icons/edit-comment.svg',
              title: 'Chỉnh sửa',
              event: () => handleShowEditer(),
            ),
            const SizedBox(height: 10),
            rowButton(
              icon: 'assets/icons/delete-comment.svg',
              title: 'Xóa',
              event: () {
                if (eventDelete != null) {
                  eventDelete!(comment.id);
                }
              },
            ),
            const SizedBox(height: 10),
            rowButton(
              icon: 'assets/icons/hide-comment.svg',
              title: 'Ẩn bình luận',
              event: () {
                if (eventChangeStatus != null) {
                  eventChangeStatus!(comment.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleShowEditer() async {
    final TextEditingController editCommentController = TextEditingController();
    editCommentController.text = comment.content;
    // final RxString images =
    //     comment.images == null ? ''.obs : comment.images!.obs;
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
            Text(
              'Chỉnh sửa',
              style: TextThemes.text15_500,
            ),
            const SizedBox(height: 16),
            const Divider(
              height: 1,
              color: Color(0xFF353542),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xFF3F3F40),
                          ),
                          child: TextField(
                            controller: editCommentController,
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
                              hintText: 'Viết bình luận...',
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
                        Visibility(
                          visible: comment.images != null &&
                              comment.images!.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ImageContainer(
                                image: comment.images,
                                height: 100,
                                widget: 100,
                                replaceImage: '',
                              ),
                            ),
                          ),
                        ),
                        // Obx(
                        //   () => Visibility(
                        //     visible: images.value.isNotEmpty,
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(top: 8),
                        //       child: Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           ClipRRect(
                        //             borderRadius: BorderRadius.circular(12),
                        //             child: ImageContainer(
                        //               image: comment.images,
                        //               height: 100,
                        //               widget: 100,
                        //               replaceImage: '',
                        //             ),
                        //           ),
                        //           const SizedBox(width: 4),
                        //           IconButton(
                        //             // onPressed: () => setSelectImage(null),
                        //             onPressed: () => images.value = '',
                        //             style: IconButton.styleFrom(
                        //               minimumSize: Size.zero,
                        //               padding: EdgeInsets.zero,
                        //               tapTargetSize:
                        //                   MaterialTapTargetSize.shrinkWrap,
                        //               elevation: 0,
                        //             ),
                        //             icon: SvgPicture.asset(
                        //                 'assets/icons/remove-image.svg'),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: () => Get.back(),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(0xFFC7C9D9),
                    ),
                    child: const Text(
                      'Hủy',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF555770),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      if (eventEdit != null) {
                        eventEdit!(
                          commentId: comment.id,
                          content: editCommentController.text,
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(0xFFFF6E47),
                    ),
                    child: const Text(
                      'Cập nhật',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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

  Widget rowButton({
    required String icon,
    required String title,
    required void Function() event,
  }) {
    return TextButton(
      onPressed: event,
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextThemes.text14_500,
          ),
        ],
      ),
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
}

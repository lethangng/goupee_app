// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/Exam/comment_model.dart';
import '../../utils/text_themes.dart';
import 'comment/comment.dart';
import 'comment/comment_tree_widget.dart';
import 'comment/tree_theme_data.dart';

class CommentTree extends StatelessWidget {
  const CommentTree({
    super.key,
    required this.id,
    required this.commentContainerData,
    required this.isShowAll,
    required this.eventShowAll,
    required this.eventPhanHoi,
  });

  // final OnThiViewModel onThiViewModel = Get.find<OnThiViewModel>();
  final int id;
  final CommentModel commentContainerData;
  final bool isShowAll;
  final void Function({required int idRoot}) eventShowAll;
  final void Function({required Comment comment}) eventPhanHoi;

  @override
  Widget build(BuildContext context) {
    return CommentTreeWidget<Comment, Comment>(
      commentContainerData.commentRoot,
      commentContainerData.listChileComment,
      treeThemeData: TreeThemeData(
        lineColor: commentContainerData.listChileComment.isNotEmpty
            ? const Color(0xFF4E4E61)
            : Colors.transparent,
        lineWidth: commentContainerData.listChileComment.isNotEmpty ? 1.25 : 0,
      ),
      avatarRoot: (context, data) => avatarContainer(
        size: 20,
        image: data.avatar,
      ),
      avatarChild: (context, data) => avatarContainer(
        size: 16,
        image: data.avatar,
      ),
      contentChild: (context, data) {
        if (isShowAll) {
          return commentContainer(
            context: context,
            comment: data,
          );
        } else {
          if (data.avatar == null) {
            return GestureDetector(
              onTap: () => eventShowAll(idRoot: id),
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${data.content}',
                  overflow: TextOverflow.ellipsis,
                  style: TextThemes.text12_600,
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Row(
                children: [
                  Text(
                    '${data.userName}',
                    style: TextThemes.text12_600,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${data.content}',
                      overflow: TextOverflow.ellipsis,
                      style: TextThemes.text12_400,
                    ),
                  ),
                ],
              ),
            );
          }
        }
      },
      contentRoot: (context, data) {
        return commentContainer(
          context: context,
          comment: data,
        );
      },
    );
  }

  PreferredSize avatarContainer({
    required double size,
    required String? image,
  }) {
    return PreferredSize(
      preferredSize: Size.fromRadius(size),
      child: image != null
          ? CircleAvatar(
              radius: size,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage(image),
            )
          : const SizedBox(),
    );
  }

  Widget commentContainer({
    required BuildContext context,
    required Comment comment,
    // required int idChild,
    // required String name,
    // required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF3F3F40),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${comment.userName}',
                style: TextThemes.text14_600,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${comment.content}',
                style: TextThemes.text12_400,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            button3(title: '12p'),
            button3(title: 'Thích', event: () {}),
            button3(
              title: 'Phản hồi',
              event: () => eventPhanHoi(comment: comment),
            ),
            button3(title: 'Tặng G', event: () {}),
            button3(title: '2.6k', icon: 'assets/icons/heart-icon.svg'),
            button3(title: '68', icon: 'assets/icons/heart-icon.svg'),
          ],
        ),
      ],
    );
  }

  Widget button3({
    required String title,
    String? icon,
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
                    SvgPicture.asset(icon),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

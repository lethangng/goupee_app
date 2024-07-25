// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../views/widgets/comment/comment.dart';

class CommentModel {
  final int id;
  final Comment commentRoot;
  final List<Comment> listChileComment;
  bool isShowAll;

  CommentModel({
    required this.id,
    required this.commentRoot,
    required this.listChileComment,
    required this.isShowAll,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Comment {
  // ignore: constant_identifier_names
  static const TAG = 'Comment';

  final int id;
  final int? idRoot;
  final String? avatar;
  final String? userName;
  String? content;

  Comment({
    required this.id,
    required this.idRoot,
    required this.avatar,
    required this.userName,
    required this.content,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AnswerModel {
  final int id;
  final String title;
  final String value;
  bool isSelect;
  final bool isTrue;

  AnswerModel({
    required this.id,
    required this.title,
    required this.value,
    required this.isSelect,
    required this.isTrue,
  });
}

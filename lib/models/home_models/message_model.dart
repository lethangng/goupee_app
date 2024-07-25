// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  final String messageType;
  final String image;
  final String title;
  final String title2;
  final String desc;
  final List<String> listData;
  final void Function()? event;

  MessageModel({
    required this.messageType,
    required this.image,
    required this.title,
    required this.title2,
    required this.desc,
    required this.listData,
    this.event,
  });
}

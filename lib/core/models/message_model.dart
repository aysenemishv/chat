class MessageModel {
  int id;
  String type;
  bool isMe;
  bool read;
  int userId;
  DateTime time;
  List<String>? imageUrls;
  String? text;

  MessageModel({
    required this.id,
    required this.isMe,
    required this.read,
    required this.time,
    required this.type,
    required this.userId,
    this.imageUrls,
    required this.text,
  });

  factory MessageModel.fromJson(int id, String text, bool isMe) {
    return MessageModel(
      id: id,
      isMe: isMe,
      read: true,
      time: DateTime.now(),
      type: 'text',
      userId: 1,
      text: text,
    );
  }
}

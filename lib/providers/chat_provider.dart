import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:chat/data/fake_data.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatUser> users = chatUsers;

  void removeChatUser(int id) {
    users.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  bool shouldScroll = false;
  List<MessageModel> messages = fakeMessages;
  void addMessage(MessageModel message) {
    messages.add(message);
    shouldScroll = true;
    //   messages.add(message);

    notifyListeners();
  }

  void markScrollDone() {
    shouldScroll = false;
  }

  bool isSendedPhoto = false;
  void sendedPhoto(bool isSended) {
    isSendedPhoto = isSended;
    notifyListeners();
  }
}

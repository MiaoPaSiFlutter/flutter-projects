import 'package:flutter/foundation.dart';
import '../data/datasources/datasource_contract.dart';
import '../models/chat.dart';
import '../models/local_message.dart';

abstract class BaseViewModel {
  IDatasource _datasource;

  BaseViewModel(this._datasource);

  @protected
  Future<void> addMessage(LocalMessage message) async {
    if (!await _isExistingChat(message.chatId)) {
      final chat = Chat(message.chatId, ChatType.individual, membersId: [
        {message.chatId: ""}
      ]);
      await createNewChat(chat);
    }
    await _datasource.addMessage(message);
  }

  Future<bool> _isExistingChat(String chatId) async {
    return await _datasource.findChat(chatId) != null;
  }

  Future<void> createNewChat(Chat chat) async {
    await _datasource.addChat(chat);
  }
}

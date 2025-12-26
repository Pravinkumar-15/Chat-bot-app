import 'package:chat_app_flutter/models/comment_model.dart';
import 'package:chat_app_flutter/services/chat_repository.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider(this._repository);

  final ChatRepository _repository;

  bool _isLoading = false;
  List<CommentModel> _comments = <CommentModel>[];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<CommentModel> get comments => _comments;
  String? get errorMessage => _errorMessage;

  Future<void> loadComments({int limit = 10}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _comments = await _repository.getComments(limit: limit);
    } catch (e) {
      _errorMessage = e.toString();
      _comments = <CommentModel>[];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

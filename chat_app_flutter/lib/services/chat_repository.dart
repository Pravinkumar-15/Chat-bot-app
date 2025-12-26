import 'package:chat_app_flutter/services/chat_api_services.dart';
import 'package:chat_app_flutter/models/comment_model.dart';

class ChatRepository {
  ChatRepository(this._apiServices);

  final ChatApiServices _apiServices;

  Future<List<CommentModel>> getComments({int limit = 10}) {
    return _apiServices.fetchComments(limit: limit);
  }
}

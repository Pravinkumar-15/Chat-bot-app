import 'dart:convert';

import 'package:chat_app_flutter/models/comment_model.dart';
import 'package:http/http.dart' as http;

class ChatApiServices {
  final String _baseUrl = 'https://dummyjson.com';

  Future<List<CommentModel>> fetchComments({int limit = 10}) async {
    final uri = Uri.parse('$_baseUrl/comments?limit=$limit');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded =
          json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> raw =
          (decoded['comments'] as List<dynamic>?) ?? <dynamic>[];
      return raw
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Failed to load comments. Status: ${response.statusCode}');
  }
}

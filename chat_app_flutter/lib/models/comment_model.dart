class CommentUserModel {
  const CommentUserModel({
    required this.id,
    required this.username,
    required this.fullName,
  });

  final int id;
  final String username;
  final String fullName;

  CommentUserModel copyWith({int? id, String? username, String? fullName}) {
    return CommentUserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
    );
  }

  factory CommentUserModel.fromJson(Map<String, dynamic> json) {
    return CommentUserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: (json['username'] as String?) ?? '',
      fullName: (json['fullName'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'fullName': fullName};
  }
}

class CommentModel {
  const CommentModel({
    required this.id,
    required this.body,
    required this.postId,
    required this.likes,
    required this.user,
  });

  final int id;
  final String body;
  final int postId;
  final int likes;
  final CommentUserModel user;

  CommentModel copyWith({
    int? id,
    String? body,
    int? postId,
    int? likes,
    CommentUserModel? user,
  }) {
    return CommentModel(
      id: id ?? this.id,
      body: body ?? this.body,
      postId: postId ?? this.postId,
      likes: likes ?? this.likes,
      user: user ?? this.user,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      body: (json['body'] as String?) ?? '',
      postId: (json['postId'] as num?)?.toInt() ?? 0,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      user: CommentUserModel.fromJson(
        (json['user'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'postId': postId,
      'likes': likes,
      'user': user.toJson(),
    };
  }
}

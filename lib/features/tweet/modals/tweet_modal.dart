import 'dart:convert';

class TweetModal {
  final String tweetId;
  final String content;
  final String adminId;
  final DateTime createdAt;
  TweetModal({
    required this.tweetId,
    required this.content,
    required this.adminId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'tweetId': tweetId,
      'content': content,
      'adminId': adminId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TweetModal.fromMap(Map<String, dynamic> map) {
    return TweetModal(
      tweetId: map['tweetId'] ?? '',
      content: map['content'] ?? '',
      adminId: map['adminId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModal.fromJson(String source) =>
      TweetModal.fromMap(json.decode(source));
}

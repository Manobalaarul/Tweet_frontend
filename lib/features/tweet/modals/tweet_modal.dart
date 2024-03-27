import 'dart:convert';

class TweetModal {
  final TweetDataModal tweet;
  final AdminDataModal admin;
  TweetModal({
    required this.tweet,
    required this.admin,
  });

  Map<String, dynamic> toMap() {
    return {
      'tweet': tweet.toMap(),
      'admin': admin.toMap(),
    };
  }

  factory TweetModal.fromMap(Map<String, dynamic> map) {
    return TweetModal(
      tweet: TweetDataModal.fromMap(map['tweet']),
      admin: AdminDataModal.fromMap(map['admin']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModal.fromJson(String source) =>
      TweetModal.fromMap(json.decode(source));
}

class AdminDataModal {
  final String uid;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime createdAt;
  AdminDataModal({
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AdminDataModal.fromMap(Map<String, dynamic> map) {
    return AdminDataModal(
      uid: map['uid'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminDataModal.fromJson(String source) =>
      AdminDataModal.fromMap(json.decode(source));
}

class TweetDataModal {
  final String tweetId;
  final String content;
  final String adminId;
  final DateTime createdAt;
  TweetDataModal({
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

  factory TweetDataModal.fromMap(Map<String, dynamic> map) {
    return TweetDataModal(
      tweetId: map['tweetId'] ?? '',
      content: map['content'] ?? '',
      adminId: map['adminId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetDataModal.fromJson(String source) =>
      TweetDataModal.fromMap(json.decode(source));
}

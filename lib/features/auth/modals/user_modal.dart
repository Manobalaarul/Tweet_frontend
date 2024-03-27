import 'dart:convert';

class UserModal {
  final String uid;
  final List<String> tweets;
  final String firstname;
  final String lastname;
  final String email;
  final String createdAt;

  UserModal(
      {required this.uid,
      required this.tweets,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'tweets': tweets,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'createdAt': createdAt,
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      uid: map['uid'] ?? '',
      tweets: List.from(map['tweets'] ?? []),
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      createdAt: map['createdAt'] ?? DateTime.now().toIso8601String(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModal.fromJson(String source) =>
      UserModal.fromMap(json.decode(source));
}

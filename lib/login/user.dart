import 'dart:convert';

List<UserFetch> userFromJson(String str) => List<UserFetch>.from(json.decode(str).map((x) => UserFetch.fromJson(x)));

class UserFetch {
  String id;
  String email;
  String name;
  String security_key;

  UserFetch({
    required this.id,
    required this.email,
    required this.name,
    required this.security_key
  });

  bool selected = false;

  factory UserFetch.fromJson(Map<String, dynamic> json) => UserFetch(
      id: json["_id"] ?? "",
      email: json["email"] ?? "",
      name: json["name"] ?? "",
      security_key: json["security_key"] ?? ""
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "security_key": security_key
  };
}
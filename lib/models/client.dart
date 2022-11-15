import 'dart:convert';

List<ClientFetch> userFromJson(String str) => List<ClientFetch>.from(json.decode(str).map((x) => ClientFetch.fromJson(x)));

class ClientFetch {
  String id;
  String name;
  String time;

  ClientFetch({
    required this.id,
    required this.time,
    required this.name,
  });

  bool selected = false;

  factory ClientFetch.fromJson(Map<String, dynamic> json) => ClientFetch(
      id: json["_id"] ?? "",
      time: json["email"] ?? "",
      name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "time": name,
    "name": name
  };
}
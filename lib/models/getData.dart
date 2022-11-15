import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TodoService {
  Future<List<Client>> getClientsDatas() async {
    const url = 'https://scaleapplication.herokuapp.com/getClients';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final todos = json.map((e) {
        return Client(
          id: e['id'],
          name: e['name'],
          time: e['time'],
          stylist_id: e['stylist_id'],
          verified: e['verified'],
        );
      }).toList();
      return todos;
    }
    return [];
    // throw "Something went wrong";
  }
}



class Client {
  final String name, time, stylist_id, verified;
  var id;
  // final Array previous_recipe;
  // late bool status;
  // Client(this.id, this.name, this.time, this.stylist_id, this.verified);
  Client({
    required this.id,
    required this.name,
    required this.time,
    required this.stylist_id,
    required this.verified
  });
}

class TodoProvider extends ChangeNotifier {
  final _service = TodoService();
  bool isLoading = false;
  List<Client> _todos = [];
  List<Client> get todos => _todos;

  Future<void> getAllDatas() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getClientsDatas();

    _todos = response;
    isLoading = false;
    notifyListeners();
  }
}
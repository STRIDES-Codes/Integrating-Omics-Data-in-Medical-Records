import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future fetch(context, table, token) async {
  if (token != '') {
    http.Response get = await http.get(
      Uri.parse("http://127.0.0.1:8000/$table/"),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    // List body = json.decode(get.body);
    // List<User> data = body.map((e) => User.fromJson(e)).toList();
    return get.body;
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('invalid')));
    http.Response get = await http.get(
      Uri.parse("http://127.0.0.1:8000/$table/"),
    );

    return get.body;
  }
}

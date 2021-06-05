import 'dart:convert';
import 'package:http/http.dart' as http;

Future login(email, password) async {
  http.Response login = await http.post(
      Uri.parse('http://127.0.0.1:8000/auth/'),
      body: {'username': email, 'password': password});
  if (login.statusCode == 200) {
    Map aut_data = json.decode(login.body);
    return aut_data;
  }
  return "Not known";
}

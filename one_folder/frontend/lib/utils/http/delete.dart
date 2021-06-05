import 'dart:convert';

import 'package:http/http.dart' as http;

Future delete(table, id, token) async {
  if (token != '') {
    http.Response delete = await http.delete(
      Uri.parse("http://127.0.0.1:8000/$table/$id"),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    // return json.decode(delete.body);
    return null;
  } else {
    http.Response delete =
        await http.delete(Uri.parse("http://127.0.0.1:8000/$table/$id"));
    return json.decode(delete.body);
  }
}

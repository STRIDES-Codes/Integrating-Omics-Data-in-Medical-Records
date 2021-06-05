import 'dart:convert';

import 'package:http/http.dart' as http;

Future put(table, id, data, token) async {
  if (token != '') {
    http.Response update =
        await http.put(Uri.parse("http://127.0.0.1:8000/$table/$id"),
            headers: {
              'Authorization': 'Token $token',
            },
            body: data);
    return json.decode(update.body);
  } else {
    http.Response update = await http
        .put(Uri.parse("http://127.0.0.1:8000/$table/$id"), body: data);
    return json.decode(update.body);
  }
}

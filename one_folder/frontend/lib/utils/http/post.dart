import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

Future post(table, data, token) async {
  if (token != '') {
    http.Response add =
        await http.post(Uri.parse("http://127.0.0.1:8000/$table/"),
            headers: {
              'Authorization': 'Token $token',
            },
            body: data);
    return json.decode(add.body);
  } else {
    http.Response add =
        await http.post(Uri.parse("http://127.0.0.1:8000/$table/"), body: data);
    return json.decode(add.body);
  }
}

detailed_post(table, data, token) async {
  var headers = {'Authorization': 'Token $token'};
  var request =
      http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/$table/'));
  request.fields.addAll(data);

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

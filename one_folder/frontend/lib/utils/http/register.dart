import 'dart:convert';

import 'package:http/http.dart' as http;

Future register(Map data) async {
  switch (data['function']) {
    case 'Medecin':
      if (data['hospital'] == 'New') {
        Map hospital_data = {
          'name': data['hospital_name'],
          'city': data['hospital_city']
        };
        String hospital = json.encode(hospital_data);
        http.Response add_hospital = await http.post(
            Uri.parse("http://127.0.0.1:8000/hospitals/"),
            body: hospital);
        int hospital_id = json.decode(add_hospital.body)['id'].hashCode;
        Map userbody = {
          "username": data['username'],
          "email": data['email'],
          "first_name": data['first_name'],
          "last_name": data["last_name"],
          "function": "Medecin",
          "cin": data['cin'],
          'password': data['password'],
          "password2": data["passwod2"],
          "phone": data["phone"]
        };
        String userdata = json.encode(userbody);
        http.Response regiseter = await http
            .post(Uri.parse("http://127.0.0.1:8000/register/"), body: userdata);
        int userid = json.decode(regiseter.body)['id'].hashCode;
        Map medecin_data = {
          "user": userid,
          "hospital": hospital_id,
          "id_pro": data["id_pro"]
        };
        String medecinbody = json.encode(medecin_data);
        http.Response assigntodoc = await http.post(
            Uri.parse("http://127.0.0.1:8000/doctors/"),
            body: medecinbody);
        return json.decode(assigntodoc.body);
      } else {
        Map userbody = {
          "username": data['username'],
          "email": data['email'],
          "first_name": data['first_name'],
          "last_name": data["last_name"],
          "function": "Medecin",
          "cin": data['cin'],
          'password': data['password'],
          "password2": data["passwod2"],
          "phone": data["phone"]
        };
        String userdata = json.encode(userbody);
        http.Response regiseter = await http
            .post(Uri.parse("http://127.0.0.1:8000/register/"), body: userdata);
        int userid = json.decode(regiseter.body)['id'].hashCode;
        Map medecin_data = {
          "user": userid,
          "hospital": data['hospital'],
          "id_pro": data["id_pro"]
        };
        String medecinbody = json.encode(medecin_data);
        http.Response assigntodoc = await http.post(
            Uri.parse("http://127.0.0.1:8000/doctors/"),
            body: medecinbody);
        return json.decode(assigntodoc.body);
      }
    case "Admin":
      Map userbody = {
        "username": data['username'],
        "email": data['email'],
        "first_name": data['first_name'],
        "last_name": data["last_name"],
        "function": "Admin",
        "cin": data['cin'],
        'password': data['password'],
        "password2": data["passwod2"],
        "phone": data["phone"]
      };
      String userdata = json.encode(userbody);
      http.Response regiseter = await http
          .post(Uri.parse("http://127.0.0.1:8000/register/"), body: userdata);
      return json.decode(regiseter.body);
    case "Chercheur":
      Map userbody = {
        "username": data['username'],
        "email": data['email'],
        "first_name": data['first_name'],
        "last_name": data["last_name"],
        "function": "Chercheur",
        "cin": data['cin'],
        'password': data['password'],
        "password2": data["passwod2"],
        "phone": data["phone"]
      };
      String userdata = json.encode(userbody);
      http.Response regiseter = await http
          .post(Uri.parse("http://127.0.0.1:8000/register/"), body: userdata);
      int userid = json.decode(regiseter.body)['id'].hashCode;
      Map chercheur_data = {
        "user": userid,
        "affiliation": data['affiliation'],
      };
      String chercheur = json.encode(chercheur_data);
      http.Response assigntodoc = await http
          .post(Uri.parse("http://127.0.0.1:8000/doctors/"), body: chercheur);
      return json.decode(assigntodoc.body);
  }
}

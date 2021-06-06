import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/users.dart';
import 'package:frontend/utils/http/fetch.dart';
import 'package:frontend/utils/http/post.dart';
import 'package:frontend/widgets/dialogs/dashboards/admin/add_user.dart';

class AddUserForm extends StatefulWidget {
  final String token;
  final String full_name;

  AddUserForm({required this.token, required this.full_name});

  @override
  _AddUserFormState createState() => _AddUserFormState();
}

String? function;
List<String> listFunctions = ['Doctor', 'Researcher', 'Admin'];
bool isDoc = false;
bool isUser = false;
final _formKey = GlobalKey<FormState>();
late TextEditingController username_field;
late TextEditingController email_field;
late TextEditingController first_name_field;
late TextEditingController last_name_field;
late TextEditingController password_field;
late TextEditingController affiliation_field;
late TextEditingController national_id_field;
late TextEditingController id_prof_field;
late TextEditingController phone_field;

class _AddUserFormState extends State<AddUserForm> {
  @override
  void initState() {
    super.initState();

    username_field = TextEditingController();
    email_field = TextEditingController();
    password_field = TextEditingController();
    first_name_field = TextEditingController();
    last_name_field = TextEditingController();
    affiliation_field = TextEditingController();
    phone_field = TextEditingController();
    id_prof_field = TextEditingController();
    national_id_field = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    String full_name = widget.full_name;
    return Form(
        // key: _formKey,
        child: Column(children: [
      TextFormField(
        controller: email_field,
        decoration: InputDecoration(hintText: 'Email', labelText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          return null;
        },
      ),
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          return null;
        },
        obscureText: true,
        controller: password_field,
        decoration:
            InputDecoration(hintText: 'Password', labelText: 'Password'),
      ),
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          return null;
        },
        controller: username_field,
        decoration: InputDecoration(
            hintText: "Nom d'utilisateur", labelText: "Nom d'utilisateur"),
      ),
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          return null;
        },
        controller: first_name_field,
        decoration: InputDecoration(hintText: 'Prenom', labelText: "Prenom"),
      ),
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          return null;
        },
        controller: last_name_field,
        decoration: InputDecoration(hintText: 'Nom', labelText: "Nom"),
      ),
      TextFormField(
        controller: national_id_field,
        decoration:
            InputDecoration(hintText: 'National ID', labelText: "National ID"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          return null;
        },
      ),
      TextFormField(
        controller: phone_field,
        decoration: InputDecoration(hintText: 'Phone', labelText: "Phone"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          return null;
        },
      ),
      Center(
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(Icons.arrow_circle_down_sharp),
          value: function,
          hint: Text("Profession"),
          onChanged: (newValue) {
            setState(() {
              function = newValue.toString();
              if (function == 'Doctor') {
                isDoc = true;
                isUser = false;
              } else if (function == 'Resaercher') {
                isDoc = false;
                isUser = true;
              } else {
                isDoc = false;
                isUser = false;
              }
            });
          },
          items: listFunctions.map((functionItem) {
            return DropdownMenuItem(
                value: functionItem, child: Text(functionItem));
          }).toList(),
        ),
      ),
      Visibility(
        visible: isDoc,
        child: Column(
          children: [
            TextFormField(
              controller: id_prof_field,
              decoration: InputDecoration(
                  hintText: 'Professional ID', labelText: "Professional ID"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      Visibility(
        child: Column(
          children: [
            TextFormField(
              controller: affiliation_field,
              decoration: InputDecoration(
                  hintText: 'Affiliation', labelText: "Affiliation"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
            ),
          ],
        ),
        visible: isUser,
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  if (password_field.text.isEmpty ||
                      username_field.text.isEmpty ||
                      first_name_field.text.isEmpty ||
                      last_name_field.text.isEmpty ||
                      email_field.text.isEmpty ||
                      national_id_field.text.isEmpty ||
                      phone_field.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Veuillez remplire tout les champs")));
                  } else {
                    Map user_data = {
                      "username": username_field.text,
                      "first_name":
                          first_name_field.text.toString().toUpperCase(),
                      "national_id":
                          national_id_field.text.toString().toUpperCase(),
                      "email": email_field.text,
                      'last_name':
                          last_name_field.text.toString().toUpperCase(),
                      'function': function,
                      'phone': phone_field.text.toString(),
                      'password': password_field.text,
                      'is_active': true.toString()
                    };
                    post('users', user_data, token).then((value) async {
                      String new_userid = value['id'].toString();
                      switch (function) {
                        case 'Researcher':
                          Map researcher_data = {
                            "user": new_userid.toString(),
                            'affiliation':
                                affiliation_field.text.toString().toUpperCase()
                          };
                          post('researchers', researcher_data, token);
                          break;
                        case "Doctor":
                          Map medecin_data = {
                            'user': new_userid.toString(),
                            "id_pro":
                                id_prof_field.text.toString().toUpperCase()
                          };
                          post("doctors", medecin_data, token);

                          break;
                        default:
                      }

                      fetch(context, "users", token).then((user) async {
                        List body_user = json.decode(user);
                        List<User> data_user =
                            body_user.map((e) => User.fromJson(e)).toList();
                        Map content = {
                          'rows': data_user,
                          "columns": [
                            'First name',
                            "Last name",
                            'National ID',
                            "Username",
                            'Email',
                            'Phone',
                            "Role",
                            "Active"
                          ],
                          "press": () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddElement(
                                    title: 'Utilisateur',
                                    token: token,
                                    full_name: full_name,
                                  );
                                });
                          },
                          "subtitle": "User",
                          "title": "Users"
                        };

                        Navigator.pushNamed(context, 'admin', arguments: {
                          'token': token,
                          'full_name': full_name,
                          "content": content
                        });
                      });
                    });
                  }
                },
                child: Text("Add")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  ;
                },
                child: Text("Cancel")),
          )
        ],
      ),
    ]));
  }
}

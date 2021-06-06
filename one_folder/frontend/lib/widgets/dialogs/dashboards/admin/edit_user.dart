import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/users.dart';
import 'package:frontend/utils/http/delete.dart';
import 'package:frontend/utils/http/fetch.dart';
import 'package:frontend/utils/http/put.dart';
import 'package:frontend/widgets/dialogs/dashboards/admin/add_user.dart';

class EditUser extends StatefulWidget {
  final String title;
  final User user;
  final String token;
  final String full_name;

  const EditUser(
      {Key? key,
      required this.title,
      required this.user,
      required this.token,
      required this.full_name})
      : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

int? hospital_id;
bool addHost = false;
String? function;
// final _formKey = GlobalKey<FormState>();

class _EditUserState extends State<EditUser> {
  late TextEditingController username_field;
  late TextEditingController first_name_field;
  late TextEditingController last_name_field;
  late TextEditingController email_field;
  late TextEditingController cin_field;
  late TextEditingController phone_field;
  late bool is_active;

  @override
  void initState() {
    super.initState();

    username_field = TextEditingController(text: widget.user.username);
    first_name_field = TextEditingController(text: widget.user.first_name);
    last_name_field = TextEditingController(text: widget.user.last_name);
    email_field = TextEditingController(text: widget.user.email);
    cin_field = TextEditingController(text: widget.user.cin);
    phone_field = TextEditingController(text: widget.user.phone);
    is_active = widget.user.is_active;
  }

  Widget build(BuildContext context) {
    String current_full_name =
        widget.user.first_name + ' ' + widget.user.last_name;
    return AlertDialog(
      title: Text("Modifier $current_full_name"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              child: Column(
            children: [
              TextFormField(
                controller: username_field,
                decoration: InputDecoration(labelText: "Username"),
              ),
              TextFormField(
                controller: first_name_field,
                decoration: InputDecoration(labelText: "First name"),
              ),
              TextFormField(
                controller: last_name_field,
                decoration: InputDecoration(labelText: "Last name"),
              ),
              TextFormField(
                controller: cin_field,
                decoration: InputDecoration(labelText: "National ID"),
              ),
              TextFormField(
                controller: phone_field,
                decoration: InputDecoration(labelText: "Phone"),
              ),
              TextFormField(
                controller: email_field,
                decoration: InputDecoration(labelText: "Email"),
              ),
              Row(
                children: [
                  Text("Active ?"),
                  Checkbox(
                      value: is_active,
                      onChanged: (value) {
                        setState(() {
                          is_active = value!;
                        });
                      }),
                ],
              )
            ],
          ))
        ],
      ),
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Map new_user_data = {
                      'first_name':
                          first_name_field.text.toString().toUpperCase(),
                      "last_name":
                          last_name_field.text.toString().toUpperCase(),
                      "is_active": is_active.toString(),
                      "phone": phone_field.text.toString(),
                      "national_id": cin_field.text.toString().toUpperCase(),
                      "username": username_field.text.toString(),
                      "email": email_field.text.toString(),
                    };
                    put('users', widget.user.id, new_user_data, widget.token)
                        .then((value) {
                      fetch(context, "users", widget.token).then((user) async {
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
                                    title: 'User',
                                    token: widget.token,
                                    full_name: widget.full_name,
                                  );
                                });
                          },
                          "subtitle": "User",
                          "title": "Users"
                        };

                        Navigator.pushNamed(context, 'admin', arguments: {
                          'token': widget.token,
                          'full_name': widget.full_name,
                          "content": content
                        });
                      });
                    });
                  },
                  child: Text("Modifier")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    delete('users', widget.user.id, widget.token).then((value) {
                      fetch(context, "users", widget.token).then((user) async {
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
                                    title: 'User',
                                    token: widget.token,
                                    full_name: widget.full_name,
                                  );
                                });
                          },
                          "subtitle": "Utilisateur",
                          "title": "Utilisateurs"
                        };

                        Navigator.pushNamed(context, 'admin', arguments: {
                          'token': widget.token,
                          'full_name': widget.full_name,
                          "content": content
                        });
                      });
                    });
                  },
                  child: Text("Delete")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text("Cancel")),
            )
          ],
        )
      ],
    );
  }
}

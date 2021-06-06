import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/researcher.dart';
import 'package:frontend/models/doctors.dart';
import 'package:frontend/models/patients.dart';
import 'package:frontend/models/users.dart';
import 'package:frontend/utils/constents/arguments.dart';
import 'package:frontend/utils/http/fetch.dart';
import 'package:frontend/widgets/dialogs/dashboards/admin/add_user.dart';
import 'package:frontend/widgets/lists/drawerlist.dart';
import 'package:frontend/widgets/navbars/dashboards/sidemenue.dart';
import 'package:frontend/widgets/screens/admin/screen.dart';
import 'package:frontend/utils/constents/colors.dart';

class AdminViwe extends StatelessWidget {
  const AdminViwe({
    Key? key,
    required this.full_name,
    required this.content,
    required this.token,
    // required this.full_name,
  }) : super(key: key);
  final String full_name;
  final String token;
  final content;

  @override
  Widget build(BuildContext context) {
    List<Widget> menu_items = [
      DrawerHeader(child: Text("I Folder")),
      DrawerList(
          title: "Users",
          press: () {
            fetch(context, "users", token).then((user) {
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
                          title: 'Users',
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
          }),
      DrawerList(
          title: "Doctors",
          press: () {
            fetch(context, "doctors", token).then((value) {
              List body = json.decode(value);
              List<Doctor> data = body.map((e) => Doctor.fromJson(e)).toList();
              Map content = {
                'rows': data,
                "columns": [
                  'First name',
                  "Last name",
                  'National ID',
                  "Username",
                  'Email',
                  'Phone',
                  "Professional ID",
                ],
                "press": () {},
                "subtitle": "Doctor",
                "title": "Doctors"
              };

              Navigator.pushNamed(context, 'admin', arguments: {
                'token': token,
                'full_name': full_name,
                "content": content
              });
            });
          }),
      DrawerList(
          title: "researcher",
          press: () {
            fetch(context, "researcher", token).then((value) {
              List body = json.decode(value);
              List<Researcher> data =
                  body.map((e) => Researcher.fromJson(e)).toList();
              print(data);
              Map content = {
                'rows': data,
                "columns": [
                  'First name',
                  "Last name",
                  'National ID',
                  "Username",
                  'Email',
                  'Phone',
                  "Affiliation",
                ],
                "press": () {},
                "subtitle": "Researcher",
                "title": "Researchers"
              };

              Navigator.pushNamed(context, 'admin', arguments: {
                'token': token,
                'full_name': full_name,
                "content": content
              });
            });
          }),
      DrawerList(
          title: "Patients",
          press: () {
            fetch(context, "patients", token).then((value) {
              List body = json.decode(value);
              List<Patient> data =
                  body.map((e) => Patient.fromJson(e)).toList();
              Map content = {
                'rows': data,
                "columns": [
                  'Doctor',
                  'Gender',
                  'Birthdate',
                  'Onset date',
                  // 'Symptomes au moment de declaration',
                ],
                "press": () {},
                "subtitle": "Patient",
                "title": "Patients"
              };

              Navigator.pushNamed(context, 'admin', arguments: {
                'token': token,
                'full_name': full_name,
                "content": content
              });
            });
          }),
    ];
    return Container(
      child: Scaffold(
        body: SafeArea(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: SideMenue(
            content: menu_items,
          )),
          Expanded(
            child: Screen(
              full_name: full_name,
              token: token,
              function: "Admin",
              screen_rows: content['rows'],
              screen_columns: content['columns'],
              screen_press: content['press'],
              screen_subtitle: content['subtitle'],
              screen_title: content['title'],
            ),
            flex: 5,
          )
        ])),
      ),
    );
  }
}

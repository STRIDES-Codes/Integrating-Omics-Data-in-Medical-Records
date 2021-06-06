import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/doctors.dart';
import 'package:frontend/utils/http/fetch.dart';
import 'package:frontend/utils/http/put.dart';

class EditDoctor extends StatefulWidget {
  final title;
  final Doctor user;
  final token;
  final full_name;
  EditDoctor({
    Key? key,
    required this.title,
    required this.user,
    required this.token,
    required this.full_name,
  }) : super(key: key);

  @override
  _EditDoctorState createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  TextEditingController hospitalname_field = new TextEditingController();
  TextEditingController hospitalcity_field = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.user.first_name + ' ' + widget.user.last_name;
    return AlertDialog(
      title: Text("Edit $name"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text("Annuler")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Map medecin_data = {};
                put("doctors", widget.user.id.toString(), medecin_data,
                        widget.token)
                    .then((value) {
                  fetch(context, "doctors", widget.token).then((value) {
                    List body = json.decode(value);
                    List<Doctor> data =
                        body.map((e) => Doctor.fromJson(e)).toList();
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
                      "subtitle": "Medecin",
                      "title": "Medecins"
                    };

                    Navigator.pushNamed(context, 'admin', arguments: {
                      'token': widget.token,
                      'full_name': widget.full_name,
                      "content": content
                    });
                  });
                });
              },
              child: Text("Edit")),
        )
      ],
    );
  }
}

import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/patients.dart';
import 'package:frontend/utils/functions/chekdoctor.dart';
import 'package:frontend/utils/functions/switchnull.dart';
import 'package:frontend/utils/http/fetch.dart';
import 'package:frontend/utils/http/post.dart';

class AddPatient extends StatefulWidget {
  final token;
  final id;
  final full_name;

  AddPatient(
      {Key? key,
      required this.id,
      required this.full_name,
      required this.token})
      : super(key: key);

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  String? gender;
  String? state;
  // File? file;
  List<String> listGenders = ['Male', 'Female'];
  List<String> listStatus = [
    'Asymptomatic',
    "Deceased",
    "Mild",
    'Recovered',
    "Sever"
  ];
  late TextEditingController first_name_field;
  late TextEditingController last_name_field;
  late TextEditingController birthday_name_field;
  late TextEditingController cin_field;
  late TextEditingController symptoms_field;
  late TextEditingController chronic_field;
  late TextEditingController infections_field;
  late TextEditingController status_ctrl;
  late TextEditingController infos_field;
  late bool is_vaccinated;
  late bool is_reinfected;
  late bool? is_allowed;
  late bool is_symptoms;
  DateTime? _birthday;
  String? _virus;
  String? _ace;
  List<int>? _file;
  String virus = '';
  String ace = '';
  var validate;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // validate = null;
    first_name_field = TextEditingController();
    last_name_field = TextEditingController();
    status_ctrl = TextEditingController();
    birthday_name_field = TextEditingController();
    cin_field = TextEditingController();
    symptoms_field = TextEditingController();
    infections_field = TextEditingController();
    chronic_field = TextEditingController();
    infos_field = TextEditingController();
    is_symptoms = false;
    is_allowed = false;

    // DateTime _birthday = DateTime(2020);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add patient"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                            controller: first_name_field,
                            decoration: InputDecoration(
                                hintText: "First name",
                                labelText: "First name"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                            controller: last_name_field,
                            decoration: InputDecoration(
                                hintText: "Last name", labelText: "Last name"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                            controller: cin_field,
                            decoration: InputDecoration(
                                hintText: "National ID",
                                labelText: "National ID"),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: DropdownButton(
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_circle_down_sharp),
                                  value: gender,
                                  hint: Text("Gender"),
                                  onChanged: (newValue) {
                                    setState(() {
                                      gender = newValue.toString();
                                    });
                                  },
                                  items: listGenders.map((functionItem) {
                                    return DropdownMenuItem(
                                        value: functionItem,
                                        child: Text(functionItem));
                                  }).toList(),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: TextFormField(
                                  controller: status_ctrl,
                                  decoration: InputDecoration(
                                      hintText: "Status", labelText: "Status"),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(_birthday == null
                                    ? "Pas de date choisie"
                                    : "La date choisie: " +
                                        _birthday.toString().split(' ')[0]),
                                TextButton(
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2222),
                                              helpText: "Date de naissance",
                                              fieldLabelText:
                                                  "Date de naissance",
                                              confirmText: "Valider",
                                              cancelText: "Annuler")
                                          .then((date) {
                                        setState(() {
                                          _birthday = date;
                                        });
                                      });
                                    },
                                    child:
                                        Text("Choisir une date de naissance")),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Reinfecte ?"),
                                    Checkbox(
                                        value: is_reinfected,
                                        onChanged: (value) {
                                          setState(() {
                                            is_reinfected = value!;
                                          });
                                        })
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Vaccinee ?"),
                                    Checkbox(
                                        value: is_vaccinated,
                                        onChanged: (value) {
                                          setState(() {
                                            is_vaccinated = value!;
                                          });
                                        })
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  TextField(
                    controller: chronic_field,
                    decoration: InputDecoration(
                        hintText: "Maladies chroniques",
                        labelText: "Maladies chroniques"),
                  ),
                  TextField(
                    controller: symptoms_field,
                    readOnly: is_symptoms,
                    decoration: InputDecoration(
                        hintText: "Symptomes", labelText: "Symptomes"),
                  ),
                  TextField(
                    controller: infos_field,
                    decoration: InputDecoration(
                        hintText: "Autre informations",
                        labelText: "Autre infromations"),
                  ),
                  Row(
                    children: [
                      Text(_virus == null
                          ? "Sequence virale"
                          : "La sequence virale choisie " + _virus.toString()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () async {
                              Future<FilePickerResult?> file =
                                  FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowMultiple: false,
                                      allowedExtensions: [
                                    'fasta'
                                  ]).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _virus = value.files.single.name;
                                  });
                                  _file = value.files.single.bytes;
                                  virus = String.fromCharCodes(_file!);
                                }
                              });
                            },
                            child: Text("Importer")),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(_ace == null
                          ? "Sequence ACE2"
                          : "La sequence ACE2 choisie " + _ace.toString()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () async {
                              Future<FilePickerResult?> file =
                                  FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowMultiple: false,
                                      allowedExtensions: [
                                    'fasta'
                                  ]).then((value) {
                                if (value != null) {
                                  List<int> file_ace =
                                      value.files.single.bytes!.toList();
                                  ace = String.fromCharCodes(file_ace);
                                  setState(() {
                                    _ace = value.files.single.name;
                                  });
                                }
                              });
                            },
                            child: Text("Importer")),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          "Je soussigne avec toute responsabilite que ce pateint a signe un consentement eclaire pour soumettre se donnees dans la platforme"),
                      Checkbox(
                          value: is_allowed,
                          onChanged: (value) {
                            setState(() {
                              is_allowed = value;
                              switch (is_allowed) {
                                case false:
                                  validate = null;
                                  break;
                                case true:
                                  if (_formKey.currentState!.validate()) {
                                    if (_birthday != null && gender != null) {
                                      if (ace == '' && virus == "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Veuillez donnner une sequnece au minimum')));
                                      } else {
                                        if (ace == '') {
                                          validate = () {
                                            Map patient_data = {
                                              "cin":
                                                  cin_field.text.toUpperCase(),
                                              "gender": gender,
                                              "birthdate": _birthday
                                                  .toString()
                                                  .split(" ")[0],
                                              "first_name": first_name_field
                                                  .text
                                                  .toUpperCase(),
                                              "last_name": last_name_field.text
                                                  .toString()
                                                  .toUpperCase(),
                                              "onset_symptoms": switchnull(
                                                  symptoms_field.text),
                                              "chronic_disease": switchnull(
                                                  chronic_field.text),
                                              "vaccinated":
                                                  is_vaccinated.toString(),
                                              "reinfected":
                                                  is_reinfected.toString(),
                                              "infos":
                                                  switchnull(infos_field.text),
                                              "doctor": widget.id.toString()
                                            };
                                            // print(patient_data);
                                            post('patients', patient_data,
                                                    widget.token)
                                                .then((value) {
                                              String patient_id =
                                                  value['id'].toString();
                                              String patient_date =
                                                  value['onset_date'];
                                              Map status_data = {
                                                "patient": patient_id,
                                                "status": state,
                                                "date": patient_date,
                                                "infos":
                                                    switchnull(infos_field.text)
                                              };
                                              // print(status_data);
                                              post("status", status_data,
                                                      widget.token)
                                                  .then((value) {
                                                Map<String, String> virus_data =
                                                    {
                                                  'patient':
                                                      patient_id.toString(),
                                                  'content': virus.toString()
                                                };
                                                detailed_post(
                                                        'virus/sequences',
                                                        virus_data,
                                                        widget.token)
                                                    .then((value) {
                                                  fetch(context, "patients",
                                                          widget.token)
                                                      .then((user) {
                                                    List body_user =
                                                        json.decode(user);
                                                    List<Patient> data_user =
                                                        body_user
                                                            .map((e) => Patient
                                                                .fromJson(e))
                                                            .toList();
                                                    List<Patient> mine =
                                                        is_mine(widget.id,
                                                            data_user);

                                                    Map content = {
                                                      'rows': mine,
                                                      "columns": [
                                                        'Prenom',
                                                        'Nom',
                                                        "CIN",
                                                        'gender',
                                                        "Date de naissance",
                                                        "Date de declaration",
                                                        "Vaccine",
                                                        "Reinfecte"
                                                      ],
                                                      "press": () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AddPatient(
                                                                  id: widget.id,
                                                                  full_name: widget
                                                                      .full_name,
                                                                  token: widget
                                                                      .token);
                                                            });
                                                      },
                                                      "subtitle": "Patient",
                                                      "title": "Mes Patients"
                                                    };

                                                    Navigator.pushNamed(
                                                        context, 'medecin',
                                                        arguments: {
                                                          'token': widget.token,
                                                          'full_name':
                                                              widget.full_name,
                                                          "content": content,
                                                          'id': widget.id
                                                        });
                                                  });
                                                });
                                              });
                                            });
                                          };
                                        } else if (virus == '') {
                                          validate = () {
                                            Map patient_data = {
                                              "cin":
                                                  cin_field.text.toUpperCase(),
                                              "gender": gender,
                                              "birthdate": _birthday
                                                  .toString()
                                                  .split(" ")[0],
                                              "first_name": first_name_field
                                                  .text
                                                  .toUpperCase(),
                                              "last_name": last_name_field.text
                                                  .toString()
                                                  .toUpperCase(),
                                              "onset_symptoms": switchnull(
                                                  symptoms_field.text),
                                              "chronic_disease": switchnull(
                                                  chronic_field.text),
                                              "vaccinated":
                                                  is_vaccinated.toString(),
                                              "reinfected":
                                                  is_reinfected.toString(),
                                              "infos":
                                                  switchnull(infos_field.text),
                                              "doctor": widget.id.toString()
                                            };
                                            // print(patient_data);
                                            post('patients', patient_data,
                                                    widget.token)
                                                .then((value) {
                                              String patient_id =
                                                  value['id'].toString();
                                              String patient_date =
                                                  value['onset_date'];
                                              Map status_data = {
                                                "patient": patient_id,
                                                "status": state,
                                                "date": patient_date,
                                                "infos":
                                                    switchnull(infos_field.text)
                                              };
                                              // print(status_data);
                                              post("status", status_data,
                                                      widget.token)
                                                  .then((value) {
                                                Map<String, String> ace_data = {
                                                  'patient':
                                                      patient_id.toString(),
                                                  'content': ace.toString()
                                                };
                                                detailed_post('ace2/sequences',
                                                        ace_data, widget.token)
                                                    .then((value) {
                                                  fetch(context, "patients",
                                                          widget.token)
                                                      .then((user) {
                                                    List body_user =
                                                        json.decode(user);
                                                    List<Patient> data_user =
                                                        body_user
                                                            .map((e) => Patient
                                                                .fromJson(e))
                                                            .toList();
                                                    List<Patient> mine =
                                                        is_mine(widget.id,
                                                            data_user);

                                                    Map content = {
                                                      'rows': mine,
                                                      "columns": [
                                                        'Prenom',
                                                        'Nom',
                                                        "CIN",
                                                        'gender',
                                                        "Date de naissance",
                                                        "Date de declaration",
                                                        "Vaccine",
                                                        "Reinfecte"
                                                      ],
                                                      "press": () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AddPatient(
                                                                  id: widget.id,
                                                                  full_name: widget
                                                                      .full_name,
                                                                  token: widget
                                                                      .token);
                                                            });
                                                      },
                                                      "subtitle": "Patient",
                                                      "title": "Mes Patients"
                                                    };

                                                    Navigator.pushNamed(
                                                        context, 'medecin',
                                                        arguments: {
                                                          'token': widget.token,
                                                          'full_name':
                                                              widget.full_name,
                                                          "content": content,
                                                          'id': widget.id
                                                        });
                                                  });
                                                });
                                              });
                                            });
                                          };
                                        } else {
                                          validate = () {
                                            Map patient_data = {
                                              "cin":
                                                  cin_field.text.toUpperCase(),
                                              "gender": gender,
                                              "birthdate": _birthday
                                                  .toString()
                                                  .split(" ")[0],
                                              "first_name": first_name_field
                                                  .text
                                                  .toUpperCase(),
                                              "last_name": last_name_field.text
                                                  .toString()
                                                  .toUpperCase(),
                                              "onset_symptoms": switchnull(
                                                  symptoms_field.text),
                                              "chronic_disease": switchnull(
                                                  chronic_field.text),
                                              "vaccinated":
                                                  is_vaccinated.toString(),
                                              "reinfected":
                                                  is_reinfected.toString(),
                                              "infos":
                                                  switchnull(infos_field.text),
                                              "doctor": widget.id.toString()
                                            };
                                            // print(patient_data);
                                            post('patients', patient_data,
                                                    widget.token)
                                                .then((value) {
                                              String patient_id =
                                                  value['id'].toString();
                                              String patient_date =
                                                  value['onset_date'];
                                              Map status_data = {
                                                "patient": patient_id,
                                                "status": state,
                                                "date": patient_date,
                                                "infos":
                                                    switchnull(infos_field.text)
                                              };
                                              // print(status_data);
                                              post("status", status_data,
                                                      widget.token)
                                                  .then((value) {
                                                Map<String, String> ace_data = {
                                                  'patient':
                                                      patient_id.toString(),
                                                  'content': ace.toString()
                                                };
                                                detailed_post('ace2/sequences',
                                                        ace_data, widget.token)
                                                    .then((value) {
                                                  Map<String, String>
                                                      virus_data = {
                                                    'patient':
                                                        patient_id.toString(),
                                                    'content': virus.toString()
                                                  };
                                                  detailed_post(
                                                          'virus/sequences',
                                                          virus_data,
                                                          widget.token)
                                                      .then((value) {
                                                    fetch(context, "patients",
                                                            widget.token)
                                                        .then((user) {
                                                      List body_user =
                                                          json.decode(user);
                                                      List<Patient> data_user =
                                                          body_user
                                                              .map((e) =>
                                                                  Patient
                                                                      .fromJson(
                                                                          e))
                                                              .toList();
                                                      List<Patient> mine =
                                                          is_mine(widget.id,
                                                              data_user);

                                                      Map content = {
                                                        'rows': mine,
                                                        "columns": [
                                                          'Prenom',
                                                          'Nom',
                                                          "CIN",
                                                          'gender',
                                                          "Date de naissance",
                                                          "Date de declaration",
                                                          "Vaccine",
                                                          "Reinfecte"
                                                        ],
                                                        "press": () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AddPatient(
                                                                    id: widget
                                                                        .id,
                                                                    full_name:
                                                                        widget
                                                                            .full_name,
                                                                    token: widget
                                                                        .token);
                                                              });
                                                        },
                                                        "subtitle": "Patient",
                                                        "title": "Mes Patients"
                                                      };

                                                      Navigator.pushNamed(
                                                          context, 'medecin',
                                                          arguments: {
                                                            'token':
                                                                widget.token,
                                                            'full_name': widget
                                                                .full_name,
                                                            "content": content,
                                                            'id': widget.id
                                                          });
                                                    });
                                                  });
                                                });
                                              });
                                            });
                                          };
                                        }
                                        ;
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Veuillez choisir un genre et une date de naissance")));
                                    }
                                  }
                              }
                              ;
                            });
                          }),
                    ],
                  )
                ]),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
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
              child:
                  ElevatedButton(onPressed: validate, child: Text("Ajouter")),
            ),
          ],
        )
      ],
    );
  }
}

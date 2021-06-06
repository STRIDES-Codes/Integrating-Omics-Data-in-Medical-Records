import 'package:flutter/material.dart';
import 'package:frontend/utils/http/auth.dart';
import 'package:frontend/utils/http/post.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late String registerText;
  late TextEditingController username_field;
  late TextEditingController email_field;
  late TextEditingController first_name_field;
  late TextEditingController last_name_field;
  late TextEditingController password_field;
  late TextEditingController affiliation_field;
  late TextEditingController national_id_field;
  late TextEditingController id_prof_field;
  late TextEditingController phone_field;
  late TextEditingController passowrd_1_field;
  late TextEditingController password_2_field;
  late bool register;
  String? function;
  List<String> listFunctions = ['Medecin', 'Chercheur', 'Admin'];
  bool isDoc = false;
  bool isUser = false;
  @override
  void initState() {
    super.initState();
    registerText = 'You don\'t have an account ? Register';
    register = false;
    username_field = TextEditingController();
    email_field = TextEditingController();
    password_field = TextEditingController();
    first_name_field = TextEditingController();
    last_name_field = TextEditingController();
    affiliation_field = TextEditingController();
    phone_field = TextEditingController();
    id_prof_field = TextEditingController();
    national_id_field = TextEditingController();
    passowrd_1_field = TextEditingController();
    password_2_field = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController email_ctrl = new TextEditingController();
    final TextEditingController password_ctrl = new TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.01),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I-Folder",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Center(
                  child: Form(
                      key: _formKey,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          children: [
                            Visibility(
                                visible: !register,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce champ est obligatoir";
                                          }
                                          return null;
                                        },
                                        controller: email_ctrl,
                                        decoration: InputDecoration(
                                            hintText: "Email",
                                            labelText: "Email"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce champ est obligatoir";
                                          }
                                          return null;
                                        },
                                        controller: password_ctrl,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            labelText: "Password"),
                                      ),
                                    ),
                                  ],
                                )),
                            // Visibility(
                            //   child: Column(
                            //     children: [
                            //       Form(
                            //           key: _formKey,
                            //           child: Column(
                            //             children: [
                            //               Row(
                            //                 children: [
                            //                   SizedBox(
                            //                     width: MediaQuery.of(context)
                            //                             .size
                            //                             .width *
                            //                         0.2,
                            //                     child: TextFormField(
                            //                       controller: first_name_field,
                            //                       decoration: InputDecoration(
                            //                           hintText: "First name",
                            //                           labelText: "First name"),
                            //                       validator: (value) {
                            //                         if (value == null ||
                            //                             value.isEmpty) {
                            //                           return "Ce champ est obligatoir";
                            //                         }
                            //                         return null;
                            //                       },
                            //                     ),
                            //                   ),
                            //                   SizedBox(
                            //                     width: MediaQuery.of(context)
                            //                             .size
                            //                             .width *
                            //                         0.2,
                            //                     child: TextFormField(
                            //                       controller: last_name_field,
                            //                       decoration: InputDecoration(
                            //                           hintText: "Last name",
                            //                           labelText: "Last name"),
                            //                       validator: (value) {
                            //                         if (value == null ||
                            //                             value.isEmpty) {
                            //                           return "Ce champ est obligatoir";
                            //                         }
                            //                         return null;
                            //                       },
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //               Row(
                            //                 children: [
                            //                   SizedBox(
                            //                     width: MediaQuery.of(context)
                            //                             .size
                            //                             .width *
                            //                         0.2,
                            //                     child: TextFormField(
                            //                       controller: email_field,
                            //                       decoration: InputDecoration(
                            //                           hintText: "Email",
                            //                           labelText: "Email"),
                            //                       validator: (value) {
                            //                         if (value == null ||
                            //                             value.isEmpty) {
                            //                           return "Ce champ est obligatoir";
                            //                         }
                            //                         return null;
                            //                       },
                            //                     ),
                            //                   ),
                            //                   SizedBox(
                            //                     width: MediaQuery.of(context)
                            //                             .size
                            //                             .width *
                            //                         0.2,
                            //                     child: TextFormField(
                            //                       controller: username_field,
                            //                       decoration: InputDecoration(
                            //                           hintText: "Username",
                            //                           labelText: "Username"),
                            //                       validator: (value) {
                            //                         if (value == null ||
                            //                             value.isEmpty) {
                            //                           return "Ce champ est obligatoir";
                            //                         }
                            //                         return null;
                            //                       },
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //               Row(
                            //                 children: [
                            //                   SizedBox(
                            //                     width: MediaQuery.of(context)
                            //                             .size
                            //                             .width *
                            //                         0.2,
                            //                     child: TextFormField(
                            //                       controller: phone_field,
                            //                       decoration: InputDecoration(
                            //                           hintText: "Phone number",
                            //                           labelText:
                            //                               "Phone number"),
                            //                       validator: (value) {
                            //                         if (value == null ||
                            //                             value.isEmpty) {
                            //                           return "Ce champ est obligatoir";
                            //                         }
                            //                         return null;
                            //                       },
                            //                     ),
                            //                   ),
                            //                   Center(
                            //                     child: DropdownButton(
                            //                       isExpanded: true,
                            //                       icon: Icon(Icons
                            //                           .arrow_circle_down_sharp),
                            //                       value: function,
                            //                       hint: Text("Profession"),
                            //                       onChanged: (newValue) {
                            //                         setState(() {
                            //                           function =
                            //                               newValue.toString();
                            //                           if (function ==
                            //                               'Medecin') {
                            //                             isDoc = true;
                            //                             isUser = false;
                            //                           } else if (function ==
                            //                               'Chercheur') {
                            //                             isDoc = false;
                            //                             isUser = true;
                            //                           } else {
                            //                             isDoc = false;
                            //                             isUser = false;
                            //                           }
                            //                         });
                            //                       },
                            //                       items: listFunctions
                            //                           .map((functionItem) {
                            //                         return DropdownMenuItem(
                            //                             value: functionItem,
                            //                             child:
                            //                                 Text(functionItem));
                            //                       }).toList(),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //               Visibility(
                            //                   visible: isDoc,
                            //                   child: Column(children: [
                            //                     TextFormField(
                            //                       controller: id_prof_field,
                            //                       decoration: InputDecoration(
                            //                           hintText:
                            //                               'ID Professionelle',
                            //                           labelText:
                            //                               "ID Professionelle"),
                            //                       validator: (value) {
                            //                         if (value == null ||
                            //                             value.isEmpty) {
                            //                           return "Ce champ est obligatoir";
                            //                         }
                            //                         return null;
                            //                       },
                            //                     )
                            //                   ])),
                            //               Visibility(
                            //                 child: Column(
                            //                   children: [
                            //                     TextFormField(
                            //                       controller: affiliation_field,
                            //                       decoration: InputDecoration(
                            //                           hintText: 'Affiliation',
                            //                           labelText: "Affiliation"),
                            //                       validator: (value) {
                            //                         if (value == null ||
                            //                             value.isEmpty) {
                            //                           return "Ce champ est obligatoir";
                            //                         }
                            //                         return null;
                            //                       },
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 visible: isUser,
                            //               ),
                            //               Row(
                            //                 children: [
                            //                   SizedBox(
                            //                     width: MediaQuery.of(context)
                            //                             .size
                            //                             .width *
                            //                         0.2,
                            //                     child: TextFormField(
                            //                       controller: passowrd_1_field,
                            //                       obscureText: true,
                            //                       decoration: InputDecoration(
                            //                           hintText: "Password",
                            //                           labelText: "Password"),
                            //                       validator: (value) {
                            //                         if (value == null ||
                            //                             value.isEmpty) {
                            //                           return "Ce champ est obligatoir";
                            //                         }
                            //                         return null;
                            //                       },
                            //                     ),
                            //                   ),
                            //                   SizedBox(
                            //                     width: MediaQuery.of(context)
                            //                             .size
                            //                             .width *
                            //                         0.2,
                            //                     child: TextFormField(
                            //                       controller: password_2_field,
                            //                       obscureText: true,
                            //                       decoration: InputDecoration(
                            //                           hintText:
                            //                               "Confirm your password",
                            //                           labelText:
                            //                               "Confirm your password"),
                            //                       validator: (value) {
                            //                         if (value == null ||
                            //                             value.isEmpty) {
                            //                           return "Ce champ est obligatoir";
                            //                         }
                            //                         return null;
                            //                       },
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ],
                            //           ))
                            //     ],
                            //   ),
                            //   visible: register,
                            // ),
                            ElevatedButton(
                                onPressed: () {
                                  switch (register) {
                                    case true:
                                      Map register_data = {};
                                      post('register', register_data, '')
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Your account has been created, wait for a validation email from our sysadmin")));
                                      });
                                      break;
                                    case false:
                                      login(email_ctrl.text, password_ctrl.text)
                                          .then((value) {
                                        if (value == 'Not known') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Email out le mot de passe est invalid')));
                                        } else {}
                                      });
                                  }
                                },
                                child: Text("Submit"))
                          ],
                        ),
                      )),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.06),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       TextButton(
                //           onPressed: () {
                //             switch (register) {
                //               case false:
                //                 setState(() {
                //                   register = true;
                //                   registerText =
                //                       "Have you already an account ? Sign in";
                //                 });
                //                 break;
                //               case true:
                //                 setState(() {
                //                   register = false;
                //                   registerText =
                //                       "Don\'t you have an account ? Register";
                //                 });
                //                 break;
                //               default:
                //             }
                //           },
                //           child: Text(registerText))
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

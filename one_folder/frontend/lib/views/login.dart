import 'package:flutter/material.dart';
import 'package:frontend/utils/http/post.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late String registerText;
  late bool register;
  @override
  void initState() {
    super.initState();
    registerText = 'You don\'t have an account ? Register';
    register = false;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController email_ctrl = new TextEditingController();
    final TextEditingController password_ctrl = new TextEditingController();
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
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      children: [
                        Visibility(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: email_ctrl,
                                decoration: InputDecoration(
                                    hintText: "Email", labelText: "Email"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: password_ctrl,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    labelText: "Password"),
                              ),
                            ),
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
                                    default:
                                  }
                                },
                                child: Text("Submit"))
                          ],
                        ))
                      ],
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            switch (register) {
                              case false:
                                setState(() {
                                  register = true;
                                  registerText =
                                      "Have you already an account ? Sign in";
                                });
                                break;
                              case true:
                                setState(() {
                                  register = false;
                                  registerText =
                                      "Don\'t you have an account ? Register";
                                });
                                break;
                              default:
                            }
                          },
                          child: Text(registerText))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

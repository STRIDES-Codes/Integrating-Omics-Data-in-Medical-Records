import 'package:flutter/material.dart';

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
    registerText = 'Register';
    register = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.01),
            width: MediaQuery.of(context).size.width * 0.5,
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
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "I-Folder",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Form(
                    child: Column(
                  children: [
                    Visibility(
                        child: Column(
                      children: [TextField()],
                    ))
                  ],
                )),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          switch (register) {
                            case false:
                              setState(() {
                                register = true;
                                registerText = "Sign in";
                              });
                              break;
                            case true:
                              setState(() {
                                register = false;
                                registerText = "Register";
                              });
                              break;
                            default:
                          }
                        },
                        child: Text(registerText))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

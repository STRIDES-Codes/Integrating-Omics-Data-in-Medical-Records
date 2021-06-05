import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01, horizontal: MediaQuery.of(context).size.width*0.01),
            width: MediaQuery.of(context).size.width*0.5,
            height: MediaQuery.of(context).size.height*0.5,
            decoration: BoxDecoration(boxShadow: [BoxShadow(color:Colors.grey.withOpacity(0.5),spreadRadius: 5,blurRadius: 7,offset: Offset(0, 3),)],borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
              
            ),
          ),
        ),
      ),
    );
  }
}
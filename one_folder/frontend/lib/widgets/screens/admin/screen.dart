import 'package:flutter/material.dart';
import 'package:frontend/widgets/forms/adduser.dart';
import 'package:frontend/widgets/navbars/dashboards/header.dart';
import 'package:frontend/widgets/screens/admin/screen_table.dart';

class Screen extends StatelessWidget {
  const Screen(
      {Key? key,
      required this.full_name,
      required this.screen_rows,
      required this.screen_press,
      required this.screen_subtitle,
      required this.screen_title,
      required this.screen_columns,
      required this.function,
      required this.token})
      : super(key: key);
  final String full_name;
  final String token;
  final String function;
  final screen_rows;
  final screen_title;
  final screen_subtitle;
  final screen_columns;
  final screen_press;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                full_name: full_name,
                token: token,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: AddingInfoBar(
                    token: token,
                    title: screen_title,
                    press: screen_press,
                    subtitle: screen_subtitle,
                    users: screen_rows,
                    columns: screen_columns,
                    full_name: full_name,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

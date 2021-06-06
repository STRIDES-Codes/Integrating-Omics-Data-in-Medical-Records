import 'package:flutter/material.dart';
import 'package:frontend/widgets/forms/adduser.dart';

class AddElement extends StatelessWidget {
  const AddElement({
    Key? key,
    required this.title,
    required this.full_name,
    required this.token,
  }) : super(key: key);
  final title;
  final String token;
  final full_name;
  @override
  Widget build(BuildContext context) {
    final bool type;
    return AlertDialog(
      title: Text("Add $title"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AddUserForm(
            token: token,
            full_name: full_name,
          )
        ],
      ),
      actions: [],
    );
  }
}

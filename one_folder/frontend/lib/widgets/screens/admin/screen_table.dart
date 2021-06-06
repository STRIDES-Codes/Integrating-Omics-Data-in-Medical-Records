import 'package:flutter/material.dart';
import 'package:frontend/models/users.dart';
import 'package:frontend/widgets/tables/admin/users.dart';

class AddingInfoBar extends StatelessWidget {
  const AddingInfoBar(
      {Key? key,
      required this.title,
      required this.press,
      required this.subtitle,
      required this.token,
      required this.columns,
      required this.full_name,
      required this.users})
      : super(key: key);
  final String title;
  final VoidCallback press;
  final token;
  final full_name;
  final String subtitle;
  final List users;
  final List<String> columns;

  @override
  Widget build(BuildContext context) {
    bool type = false;
    if (subtitle == 'Patient' ||
        subtitle == 'Chercheur' ||
        subtitle == 'Medecin' ||
        subtitle == 'Sequence virale' ||
        subtitle == "Sequence ACE2") {
      type = false;
    } else {
      type = true;
    }
    return Column(
      children: [
        Visibility(
          visible: type,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ElevatedButton.icon(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.01)),
                  onPressed: press,
                  icon: Icon(Icons.add),
                  label: Text("Ajouter un $subtitle"))
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TableDash(
                    title: title,
                    columns: columns,
                    rows: users,
                    token: token,
                    full_name: full_name,
                  )
                ],
              ),
            )),
      ],
    );
  }
}

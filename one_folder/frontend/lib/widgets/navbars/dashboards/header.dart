import 'package:flutter/material.dart';
import 'package:frontend/widgets/navbars/dashboards/profil.dart';
// import 'package:frontend/widgets/navbars/profil.dart';
// import 'package:frontend/widgets/navbars/searchbar.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.token, this.full_name})
      : super(key: key);
  final full_name;
  final token;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Table de Bord",
          style: Theme.of(context).textTheme.headline6,
        ),
        Spacer(
          flex: 2,
        ),
        // Expanded(child: SearchField()),
        ProfilCard(
          token: token,
          full_name: full_name,
        ),
      ],
    );
  }
}

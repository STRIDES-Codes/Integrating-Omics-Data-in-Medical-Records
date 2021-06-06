import 'package:flutter/material.dart';
import 'package:frontend/utils/http/post.dart';

class ProfilCard extends StatelessWidget {
  const ProfilCard({
    Key? key,
    required this.full_name,
    required this.token,
  }) : super(key: key);
  final String full_name;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(full_name),
          ),
          IconButton(
              onPressed: () {
                Map<String, String> data = {'token': token};
                detailed_post('logout', data, token).then((value) {
                  Navigator.pushNamed(context, '');
                });
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white10)),
    );
  }
}

import 'package:flutter/material.dart';

class SideMenue extends StatelessWidget {
  const SideMenue({Key? key, required this.content}) : super(key: key);
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Scrollbar(
          child: SingleChildScrollView(
              child: Column(
            children: content,
          )),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/users.dart';
import 'package:frontend/utils/functions/listing.dart';
import 'package:frontend/utils/http/fetch.dart';
import 'package:frontend/widgets/dialogs/dashboards/admin/edit_doctor.dart';
import 'package:frontend/widgets/dialogs/dashboards/admin/edit_user.dart';

class TableDash extends StatefulWidget {
  const TableDash(
      {Key? key,
      required this.columns,
      required this.rows,
      required this.title,
      required this.token,
      required this.full_name})
      : super(key: key);
  final List<String> columns;
  final List rows;
  final String title;
  final String full_name;
  final String token;

  @override
  _TableDashState createState() => _TableDashState();
}

class _TableDashState extends State<TableDash> {
  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
      child: Container(
        child: buildDataTable(widget.columns, widget.rows, context,
            widget.title, widget.token, widget.full_name),
        width: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }
}

Widget buildDataTable(columns, users, context, title, token, full_name) {
  return DataTable(
    columns: getColumns(columns),
    rows: getRows(users, context, title, token, full_name),
    sortAscending: true,
  );
}

List<DataColumn> getColumns(List<String> columns) {
  return columns.map((String column) {
    return DataColumn(
      label: Text(column),
    );
  }).toList();
}

List<DataRow> getRows(List rows, context, title, token, full_name) =>
    rows.map((user) {
      var cells;
      switch (title) {
        case 'Users':
          cells = [
            user.first_name,
            user.last_name,
            user.cin,
            user.username,
            user.email,
            user.phone,
            user.function,
            user.is_active,
          ];
          break;
        case "Patients":
          cells = [
            user.doctor,
            user.gender,
            user.birthdate,
            user.onset_date,
            // user.onset_date,
            user.vaccinated,
            user.reinfected
          ];
          break;
        default:
          cells = ['', '', '', '', '', '', ''];
      }
      return DataRow(
        cells: Utils.modelBuilder(cells, (index, cell) {
          return DataCell(Text("$cell"), onTap: () {
            switch (title) {
              case "Utilisateurs":
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EditUser(
                          title: title,
                          user: user,
                          token: token,
                          full_name: full_name);
                    });
                break;
              case "Doctor":
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EditDoctor(
                          title: title,
                          user: user,
                          token: token,
                          full_name: full_name);
                    });

                break;
            }
          });
        }),
      );
    }).toList();

class ScrollableWidget extends StatelessWidget {
  @override
  const ScrollableWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: child,
        ),
      );
}

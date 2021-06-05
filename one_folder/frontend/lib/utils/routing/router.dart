import 'package:flutter/material.dart';
import 'package:frontend/views/admin.dart';
import 'package:frontend/views/doctor.dart';
import 'package:frontend/views/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '':
        {
          return MaterialPageRoute(builder: (_) => LoginView());
        }
      case 'admin':
        {
          final args = settings.arguments as Map;
          return MaterialPageRoute(
              builder: (_) => AdminViwe(
                    full_name: args['full_name'],
                    token: args['token'],
                    content: args['content'],
                  ));
        }
      case "chercheur":
        {
          final args = settings.arguments as Map;
          return MaterialPageRoute(
              builder: (_) => AdminViwe(
                    full_name: args['full_name'],
                    token: args['token'],
                    content: args['content'],
                  ));
        }

      case "medecin":
        {
          final args = settings.arguments as Map;
          return MaterialPageRoute(
              builder: (_) => DoctorViwe(
                    full_name: args['full_name'],
                    token: args['token'],
                    id: args['id'],
                    content: args['content'],
                  ));
        }

      default:
        {
          return MaterialPageRoute(builder: (_) => LoginView());
        }
    }
  }
}
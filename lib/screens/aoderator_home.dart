import 'package:flutter/material.dart';
import 'package:tododemoapp/services/auth_service.dart';
import 'package:tododemoapp/services/user_services.dart';


class ModeratorHome extends StatefulWidget {
  const ModeratorHome({super.key});

  @override
  State<ModeratorHome> createState() => _ModeratorHomeState();
}

class _ModeratorHomeState extends State<ModeratorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Moderator Home"),
        actions: [
          IconButton(
            onPressed: () {
             AuthService().logout().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false)

              );
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}

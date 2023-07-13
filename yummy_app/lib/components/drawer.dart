import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yummy_app/screens/auth_page.dart';
import 'package:yummy_app/services/auth_service.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final User? _user = AuthService().currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text("Yummy Recipe Finder"),
          ),
          checkLogin()
        ],
      ),
    );
  }

  Widget checkLogin(){
    if (_user == null) {
      return ListTile(
            leading: const Icon(Icons.login),
            title: const Text("Login"),
            onTap: (){
              Navigator.of(context)
              .push(MaterialPageRoute(builder:(context) {
                return const LoginPage();
              },));
            },
          );
    } else {
      return ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: (){
              setState(() {
                 AuthService().signout();
              });
            },
          );
    }
  }
}
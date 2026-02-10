import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Dashboard"),
      ),
      body: FloatingActionButton(onPressed: () async {
          await firebaseAuth.signOut();
          Navigator.popAndPushNamed(context, "/login_screen");
        },
        child: Text("Logout"),),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Login")),
          TextField(
            controller: emailTextEditingController,
            decoration: InputDecoration(hintText: "Email"),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: passwordTextEditingController,
            decoration: InputDecoration(hintText: "Password"),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () async {
              if(passwordTextEditingController.text.isEmpty || emailTextEditingController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Email and Password")));
              }
              else if (passwordTextEditingController.text.length<10 || !RegExp(r'^\S.*\S$').hasMatch(passwordTextEditingController.text)){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Password")));
              }
              else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(emailTextEditingController.text)){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Email Address")));
              }
              else{
                try {
                await firebaseAuth.signInWithEmailAndPassword(
                  email: emailTextEditingController.text,
                  password: passwordTextEditingController.text,
                );
                Navigator.popAndPushNamed(context,"/dashboard_screen");
                print("Dashboard --------------------------------------------");
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Email/Password or User Does not exists")));
                }
              }
            },
            child: Text("Login"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("New User?"),
              TextButton(onPressed: () {
                Navigator.pushNamed(context, "/signup_screen");
              }, child: Text("SignUp")),
            ],
          ),
        ],
      ),
    );
  }
}

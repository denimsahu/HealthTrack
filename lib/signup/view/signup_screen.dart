import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController = TextEditingController();
  TextEditingController passwordOneTextEditingController = TextEditingController();
  TextEditingController passwordTwotextEditingController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: fullNameTextEditingController,
            decoration: InputDecoration(hint: Text("Full Name")),
          ),
          TextField(
            controller: emailTextEditingController,
            decoration: InputDecoration(hint: Text("Email")),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: phoneNumberTextEditingController,
            decoration: InputDecoration(hint: Text("Phone Number")),
            keyboardType: TextInputType.phone,
          ),
          TextField(
            controller: passwordOneTextEditingController,
            decoration: InputDecoration(hint: Text("Password")),
            obscureText: true,
          ),
          TextField(
            controller: passwordTwotextEditingController,
            decoration: InputDecoration(hint: Text("ReEnter Password")),
            obscureText: true,
          ),
          ElevatedButton(onPressed: () async {
            if(fullNameTextEditingController.text.isEmpty || emailTextEditingController.text.isEmpty || passwordOneTextEditingController.text.isEmpty || passwordTwotextEditingController.text.isEmpty ||phoneNumberTextEditingController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill Up All Feilds")));
            }
            else if (passwordOneTextEditingController.text != passwordTwotextEditingController.text){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Both Password Dosen't Match")));
            }
            else if (fullNameTextEditingController.text.length<3 || !RegExp(r'^\S.*\S$').hasMatch(fullNameTextEditingController.text)){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Valid Fullname")));
            }
            else if (passwordOneTextEditingController.text.length<10){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password is too Short")));
            }
            else if(!RegExp(r'^\S.*\S$').hasMatch(passwordOneTextEditingController.text)){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Cannot Start or End With White Spaces")));
            }
            else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(emailTextEditingController.text)){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Email Address")));
            }
            else if(phoneNumberTextEditingController.text.length!=10){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Phone Number")));
            }
            else{
              try{
                await firebaseAuth.createUserWithEmailAndPassword(email: emailTextEditingController.text, password: passwordOneTextEditingController.text);
                Navigator.pushNamedAndRemoveUntil(context, "/dashboard_screen", (Route<dynamic> route) => false);
              }
              catch(error){
                print("error while signing up "+error.toString());
              }
            }
          }, child: Text("SignUp")),
        ],
      ),
    );
  }
}

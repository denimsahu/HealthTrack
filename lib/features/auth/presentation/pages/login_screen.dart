import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/features/auth/presentation/bloc/auth_bloc.dart';

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
      appBar: AppBar(title: Text("Login")),
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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState){
                Navigator.popAndPushNamed(context, "/dashboard_screen");
              }
              else if (state is AuthFailureState){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failuremessage)));
              }
            },
            builder: (context, state) {
              return ElevatedButton( 
                onPressed: state is AuthLoadingState? (){} : () async {
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
                      context.read<AuthBloc>().add(AuthLoginEvent(email: emailTextEditingController.text, password: passwordTextEditingController.text));
                  }
                },
                child: state is AuthLoadingState? CircularProgressIndicator():Text("Login"),
              );
            },
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/signup_screen");
            },
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.titleMedium,
                text: "Don't have an account? ",
                children: [
                  TextSpan(
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blueAccent),
                    text: "Sign Up"
                    
                    )
                ]
              )
            ),
          ),
        ],
      ),
    );
  }
}

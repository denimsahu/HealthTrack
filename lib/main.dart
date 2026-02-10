import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/Login/bloc/login_bloc.dart';
import 'package:healthtrack/dashboard/bloc/dashboard_bloc.dart';
import 'package:healthtrack/dashboard/view/dashboard_screen.dart';
import 'package:healthtrack/firebase_options.dart';
import 'package:healthtrack/login/view/login_screen.dart';
import 'package:healthtrack/signup/bloc/signup_bloc.dart';
import 'package:healthtrack/signup/view/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    late String initialRoute;
    if(firebaseAuth.currentUser != null){
      initialRoute = "/dashboard_screen";
    }
    else{
      initialRoute = "/login_screen";
    }
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=> LoginBloc(),),
      BlocProvider(create: (context)=> SignupBloc()),
      BlocProvider(create: (context)=> DashboardBloc()),
    ],
    child: MaterialApp(
      routes: {
          "/login_screen":(context)=>const LoginScreen(),
          "/signup_screen":(context)=>const SignupScreen(),
          "/dashboard_screen":(context)=>const DashboardScreen(),
        },
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      ),
    );
  }
}

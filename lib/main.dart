import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/features/dashboard/data/dashboard_repository.dart';
import 'package:healthtrack/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:healthtrack/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:healthtrack/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:healthtrack/features/diagnosis/data/diagnosis_repository.dart';
import 'package:healthtrack/features/diagnosis/data/models/diagnosis.dart';
import 'package:healthtrack/features/diagnosis/presentation/bloc/diagnosis_bloc.dart';
import 'package:healthtrack/features/diagnosis/presentation/pages/add_diagnosis_screen.dart';
import 'package:healthtrack/features/diagnosis/presentation/pages/detial_diagnosis_screen.dart';
import 'package:healthtrack/features/patient/data/models/patient.dart';
import 'package:healthtrack/features/patient/data/patient_repository.dart';
import 'package:healthtrack/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:healthtrack/features/patient/presentation/pages/add_patient_screen.dart';
import 'package:healthtrack/features/diagnosis/presentation/pages/diagnosis_list_screen.dart';
import 'package:healthtrack/features/patient/presentation/pages/patient_list_screen.dart';
import 'package:healthtrack/firebase_options.dart';
import 'package:healthtrack/features/auth/presentation/pages/login_screen.dart';
import 'package:healthtrack/features/auth/presentation/pages/signup_screen.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(PatientAdapter());
  Hive.registerAdapter(DiagnosisAdapter());
  final patientBox = await Hive.openBox<Patient>('patients');
  // await Hive.deleteBoxFromDisk('diagnoses');
  final diagnosisBox = await Hive.openBox<Diagnosis>('diagnoses');
  runApp(MyApp(patientBox: patientBox,diagnosisBox: diagnosisBox,));
}

class MyApp extends StatelessWidget {
  final Box<Patient> patientBox;
  final Box<Diagnosis> diagnosisBox;
  const MyApp({super.key,required this.diagnosisBox,required this.patientBox});

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
      BlocProvider(create: (context)=> AuthBloc(),),
      BlocProvider(create: (context)=> PatientBloc(PatientRepository(patientBox: patientBox))),
      BlocProvider(create: (context)=> DiagnosisBloc(diagnosisRepository: DiagnosisRepository(diagnosisBox: diagnosisBox))),
      BlocProvider(create: (context)=> DashboardBloc(dashboardRepository: DashboardRepository(diagnosisBox: diagnosisBox, patientBox: patientBox))),
    ],
    child: MaterialApp(
      routes: {
          "/login_screen":(context)=>const LoginScreen(),
          "/signup_screen":(context)=>const SignupScreen(),
          "/dashboard_screen":(context)=>const DashboardScreen(),
          "/patient_screen":(context)=>const PatientScreen(),
          "/add_patient_screen":(context)=>const AddpatientScreen(),
          "/diagnosis_list_screen":(context)=> DiagnosisListScreen(),
          "/add_diagnosis_screen":(context)=> AddDiagnosisScreen(),
          "/detail_diagnosis_screen":(context)=> DetialDiagnosisScreen(),
        },
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      ),
    );
  }
}

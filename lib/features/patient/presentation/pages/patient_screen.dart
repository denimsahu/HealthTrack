import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/features/patient/presentation/bloc/patient_bloc.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {

  @override
  void initState() {
    context.read<PatientBloc>().add(LoadPatientsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patients"),),
      body: Center(
        child: BlocBuilder<PatientBloc, PatientState>(
          builder: (context,state){
            if(state is LoadingPatientState){
              return CircularProgressIndicator();
            }
            else if (state is ErrorPatientState){
              return Text(state.error);
            }
            else if (state is PatientLoadedState){
              return ListView.builder(
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(state.patients[index].name),
                    subtitle: Text(state.patients[index].contact),
                  );
                },
                itemCount: state.patients.length,
              );
            }
            else{
              return Text("No Patients Record Found");
            }
          },
        ),
      ),
      floatingActionButton: ElevatedButton(onPressed: (){
        Navigator.pushNamed(context, "/add_patient_screen");
      }, 
      child: Text("Add Patient")),
    );
  }
}
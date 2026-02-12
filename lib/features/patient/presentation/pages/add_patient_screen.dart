import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:healthtrack/features/patient/presentation/widgets/custom_elevated_button.dart';
import 'package:healthtrack/features/patient/presentation/widgets/custom_text_field.dart';

class AddpatientScreen extends StatefulWidget {
  const AddpatientScreen({super.key});

  @override
  State<AddpatientScreen> createState() => _AddpatientScreenState();
}

class _AddpatientScreenState extends State<AddpatientScreen> {

    TextEditingController nameTextEditingController = TextEditingController();
    TextEditingController ageTextEditingController = TextEditingController();
    TextEditingController genderTextEditingController = TextEditingController();
    TextEditingController contactTextEditingController = TextEditingController();
    TextEditingController notesTextEditingController = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admit Patient"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Please Fillup The Following Details",style:TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              customTextFeild(context: context, labelText: "Full Name",controller: nameTextEditingController),
              Container(width: MediaQuery.of(context).size.width*0.8, child: Divider(thickness: 3,radius: BorderRadius.circular(10),)),
              customTextFeild(context: context, labelText: "Age",controller: ageTextEditingController,keyboardType: TextInputType.number),
              Container(width: MediaQuery.of(context).size.width*0.8, child: Divider(thickness: 3,radius: BorderRadius.circular(10),)),
              customTextFeild(context: context, labelText: "Gender",controller: genderTextEditingController),
              Container(width: MediaQuery.of(context).size.width*0.8, child: Divider(thickness: 3,radius: BorderRadius.circular(10),)),
              customTextFeild(context: context, labelText: "Contact",controller: contactTextEditingController,keyboardType: TextInputType.phone),
              Container(width: MediaQuery.of(context).size.width*0.8, child: Divider(thickness: 3,radius: BorderRadius.circular(10),)),
              customTextFeild(context: context, labelText: "Notes"),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              BlocConsumer<PatientBloc, PatientState>(
                listener: (context, state) {
                  if(state is ErrorPatientState){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error.toString()),
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      duration: Duration(seconds: 2),
                    ));
                  }
                  else if(state is SuccessPatientAddedState){
                    Navigator.popAndPushNamed(context, "/dashboard_screen");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Patient Admitted Successfully!!"),
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      duration: Duration(seconds: 2),
                    ));
                  }

                },
                builder: (context, state) {
                  return customElevatedButton(context: context, onPressed: (){
                    context.read<PatientBloc>().add(AddPatientEvent(name: nameTextEditingController.text, age: int.parse(ageTextEditingController.text), contact: contactTextEditingController.text, gender: genderTextEditingController.text, notes: notesTextEditingController.text));
                  },
                  text: "Admit");
                },
              )
            ]
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:healthtrack/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:healthtrack/features/patient/presentation/widgets/custom_elevated_button.dart';
import 'package:healthtrack/features/patient/presentation/widgets/custom_text_field.dart';

class AddpatientScreen extends StatefulWidget {
  const AddpatientScreen({super.key});

  @override
  State<AddpatientScreen> createState() => _AddpatientScreenState();
}

class _AddpatientScreenState extends State<AddpatientScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admit Patient"),
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Patient Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Fill in the details below",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              customTextFeild(
                context: context,
                labelText: "Full Name",
                controller: nameController,
              ),

              const SizedBox(height: 20),

              customTextFeild(
                context: context,
                labelText: "Age",
                controller: ageController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

              customTextFeild(
                context: context,
                labelText: "Gender",
                controller: genderController,
              ),

              const SizedBox(height: 20),

              customTextFeild(
                context: context,
                labelText: "Contact",
                controller: contactController,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 20),

              customTextFeild(
                context: context,
                labelText: "Notes",
                controller: notesController,
              ),

              const SizedBox(height: 40),

              BlocConsumer<PatientBloc, PatientState>(
                listener: (context, state) {

                  if (state is ErrorPatientState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }

                  if (state is SuccessPatientAddedState) {
                    context.read<DashboardBloc>().add(GetDetailDashboardEvent());
                    context.read<PatientBloc>().add(LoadPatientsEvent());
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Patient admitted successfully"),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return customElevatedButton(
                    text: "Admit Patient",
                    onPressed: () {

                      if (nameController.text.isEmpty ||
                          ageController.text.isEmpty ||
                          genderController.text.isEmpty ||
                          contactController.text.isEmpty) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all required fields"),
                          ),
                        );
                        return;
                      }

                      final int? age = int.tryParse(ageController.text);

                      if (age == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Enter valid age"),
                          ),
                        );
                        return;
                      }

                      context.read<PatientBloc>().add(
                            AddPatientEvent(
                              name: nameController.text.trim(),
                              age: age,
                              contact: contactController.text.trim(),
                              gender: genderController.text.trim(),
                              notes: notesController.text.trim(),
                            ),
                          );
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
        title: const Text("Patients"),
        elevation: 2,
      ),
      body: SafeArea(
        child: BlocBuilder<PatientBloc, PatientState>(
          builder: (context, state) {

            if (state is LoadingPatientState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ErrorPatientState) {
              return Center(
                child: Text(state.error),
              );
            }

            if (state is EmptyPatientState) {
              return const Center(
                child: Text(
                  "No patient records found",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            if (state is PatientLoadedState) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.patients.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {

                  final patient = state.patients[index];

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/diagnosis_list_screen",
                          arguments: index,  // use real patientId
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent.withOpacity(0.15),
                        child: const Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                        ),
                      ),
                      title: Text(
                        patient.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          patient.notes.isEmpty
                              ? "No additional notes"
                              : patient.notes,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/add_patient_screen");
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Patient"),
      ),
    );
  }
}

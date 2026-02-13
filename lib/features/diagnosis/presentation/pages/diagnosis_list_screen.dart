import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/features/diagnosis/presentation/bloc/diagnosis_bloc.dart';

class DiagnosisListScreen extends StatefulWidget {
  const DiagnosisListScreen({super.key});

  @override
  State<DiagnosisListScreen> createState() => _DiagnosisListScreenState();
}

class _DiagnosisListScreenState extends State<DiagnosisListScreen> {
  late int patientId;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      patientId = ModalRoute.of(context)!.settings.arguments as int;
      context
          .read<DiagnosisBloc>()
          .add(GetAllDiagnosisEvent(patientId: patientId));
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diagnosis History"),
        elevation: 2,
      ),
      body: SafeArea(
        child: BlocBuilder<DiagnosisBloc, DiagnosisState>(
          builder: (context, state) {
            if (state is LoadingDiagnosisState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is EmptyDiagnosisState) {
              return const Center(
                child: Text(
                  "No diagnosis records found",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            if (state is LoadedDiagnosisState) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.allDiagnosis.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final diagnosis = state.allDiagnosis[index];

                  final analysisText = diagnosis.analysis == 0
                      ? "High Risk"
                      : diagnosis.analysis == 1
                          ? "Needs Attention"
                          : "Normal";

                  final analysisColor = diagnosis.analysis == 0
                      ? Colors.red
                      : diagnosis.analysis == 1
                          ? Colors.orange
                          : Colors.green;

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
                          "/detail_diagnosis_screen",
                          arguments: diagnosis,
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: analysisColor.withOpacity(0.15),
                        child: Icon(
                          Icons.health_and_safety,
                          color: analysisColor,
                        ),
                      ),
                      title: Text(
                        analysisText,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: analysisColor,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "Added on ${diagnosis.dateTime.day}-${diagnosis.dateTime.month}-${diagnosis.dateTime.year}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  );
                },
              );
            }

            if (state is ErrorDiagnosisState) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }

            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            "/add_diagnosis_screen",
            arguments: patientId,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

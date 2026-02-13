import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:healthtrack/features/diagnosis/data/models/diagnosis.dart';

class DetialDiagnosisScreen extends StatelessWidget {
  const DetialDiagnosisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diagnosis = ModalRoute.of(context)!.settings.arguments as Diagnosis;

    final formattedDate =
        DateFormat('dd MMM yyyy').format(diagnosis.dateTime);

    Color resultColor = diagnosis.analysis==0?Colors.red:diagnosis.analysis==1?Colors.orange: Colors.green;

    return Scaffold(
      appBar: AppBar(title: const Text("Diagnosis Detail")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(diagnosis.imageAddress),
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            /// Date
            Text(
              "Date: $formattedDate",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            /// Analysis
            Text(
              "Analysis Result",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: resultColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                diagnosis.analysis==0?"High Risk":diagnosis.analysis==1?"Need Attention":"Normal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              "Explainability",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Text(
              diagnosis.Explainability,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

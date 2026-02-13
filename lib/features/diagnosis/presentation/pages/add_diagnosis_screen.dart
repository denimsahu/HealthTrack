import 'dart:io';
import 'package:flutter/material.dart';
import 'package:healthtrack/features/diagnosis/presentation/bloc/diagnosis_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDiagnosisScreen extends StatefulWidget {
  @override
  State<AddDiagnosisScreen> createState() => _AddDiagnosisScreenState();
}

class _AddDiagnosisScreenState extends State<AddDiagnosisScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int patientId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(title: const Text("Add Diagnosis")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _selectedImage != null
                  ? Image.file(_selectedImage!, height: 200)
                  : const Text("No image selected"),
          
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text("Pick Image"),
              ),
          
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectedImage == null
                    ? null
                    : () {
                        context.read<DiagnosisBloc>().add(AddDiagnosisEvent(patientId: patientId,imagePath: _selectedImage!.path,),);
                        Navigator.popUntil(context, ModalRoute.withName('/patient_screen'));
                      },
                child: const Text("Save Diagnosis"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

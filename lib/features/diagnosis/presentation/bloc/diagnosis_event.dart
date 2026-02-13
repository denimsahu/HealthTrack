part of 'diagnosis_bloc.dart';

@immutable
sealed class DiagnosisEvent {}

class GetAllDiagnosisEvent extends DiagnosisEvent{
  final int patientId;
  GetAllDiagnosisEvent({required this.patientId});
}

class AddDiagnosisEvent extends DiagnosisEvent{
  final String imagePath;
  final int patientId;
  AddDiagnosisEvent({required this.patientId, required this.imagePath});
}


part of 'patient_bloc.dart';

@immutable
sealed class PatientState {}

final class PatientInitial extends PatientState {}

class LoadingPatientState extends PatientState{}

class ErrorPatientState extends PatientState{
  String error;
  ErrorPatientState({required this.error});
}

class SuccessPatientAddedState extends PatientState{}

class EmptyPatientState extends PatientState{}

class PatientLoadedState extends PatientState{
  List<Patient> patients;
  PatientLoadedState({required this.patients});
}
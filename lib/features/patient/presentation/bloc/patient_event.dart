part of 'patient_bloc.dart';

@immutable
sealed class PatientEvent {}

class AddPatientEvent extends PatientEvent{
  String name;
  int age;
  String contact;
  String notes;
  String gender;
  AddPatientEvent({required this.name, required this.age ,required this.contact, required this.gender, required this.notes});
}

class LoadPatientsEvent extends PatientEvent{}
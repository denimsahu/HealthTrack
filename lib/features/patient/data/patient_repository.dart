import 'package:healthtrack/features/patient/data/models/diagnosis.dart';
import 'package:healthtrack/features/patient/data/models/patient.dart';
import 'package:hive/hive.dart';

class PatientRepository {
  final Box<Patient> _patientBox;
  final Box<Diagnosis> _diagnosisBox;

  PatientRepository({required Box<Patient> patientBox, required Box<Diagnosis> diagnosisBox}):_patientBox=patientBox,_diagnosisBox=diagnosisBox ;

  Future<void> addPatient({required String name, required int age ,required String contact, required String gender, required String notes})async {
    await _patientBox.add(Patient(name: name, age: age, gender: gender, contact: contact, notes: notes));
  }

  Future<List<Patient>> getAllPatients() async {
    return await _patientBox.values.toList();
  }

}
import 'package:healthtrack/features/diagnosis/data/models/diagnosis.dart';
import 'package:healthtrack/features/patient/data/models/patient.dart';
import 'package:hive/hive.dart';

class DashboardRepository {
  final Box<Diagnosis> _diagnosisBox;
  final Box<Patient> _patientBox;

  DashboardRepository({required Box<Diagnosis> diagnosisBox, required Box<Patient> patientBox }) :_diagnosisBox=diagnosisBox, _patientBox=patientBox;

  Future<Map<String,String>> getDashboardDetails() async {
    int toalPatient = await _patientBox.length;
    int totalReports = await _diagnosisBox.length;
    return  {"toalPatient":toalPatient.toString(),"totalReports":totalReports.toString()};
  }

}
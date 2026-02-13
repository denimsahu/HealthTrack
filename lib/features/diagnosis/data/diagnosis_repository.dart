import 'dart:math';
import 'package:healthtrack/features/diagnosis/data/models/diagnosis.dart';
import 'package:hive/hive.dart';

class DiagnosisRepository {
  final Box<Diagnosis> _diagnosisBox;
  String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _random = Random();
  DiagnosisRepository({required Box<Diagnosis> diagnosisBox}):_diagnosisBox=diagnosisBox;


  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));

  Future<void> addDiagnosis({required int patientId, required String imageAddress}) async {
    int analysis = _random.nextInt(3);
    String Explainability = _getRandomString(_random.nextInt(99));
    try{
      await _diagnosisBox.add(Diagnosis(patientId: patientId, imageAddress: imageAddress, analysis: analysis, Explainability: Explainability, dateTime:DateTime.now()));
    }
    catch(error){
      print(error.toString());
    }
  }

  Future<List<Diagnosis>> getAllDiagnosis({required int patientId}) async { 
    List<Diagnosis> list = await _diagnosisBox.values.where((diagnosis){return diagnosis.patientId==patientId;}).toList(); 
    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return list;
  }

}
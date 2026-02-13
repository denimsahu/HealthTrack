import 'package:hive/hive.dart';

part 'diagnosis.g.dart';

@HiveType(typeId: 1)
class Diagnosis extends HiveObject {

  @HiveField(0)
  int patientId;

  @HiveField(1)
  String imageAddress;

  @HiveField(2)
  int analysis;

  @HiveField(3)
  String Explainability;

  @HiveField(4)
  DateTime dateTime;

  Diagnosis({
    required this.patientId,
    required this.imageAddress,
    required this.analysis,
    required this.Explainability,
    required this.dateTime
  });
}

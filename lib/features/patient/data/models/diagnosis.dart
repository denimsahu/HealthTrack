import 'package:hive/hive.dart';

part 'diagnosis.g.dart';

@HiveType(typeId: 1)
class Diagnosis extends HiveObject {

  @HiveField(0)
  int patientId;

  @HiveField(1)
  String imageAddress;

  @HiveField(2)
  String analysis;

  @HiveField(3)
  String Explainability;

  Diagnosis({
    required this.patientId,
    required this.imageAddress,
    required this.analysis,
    required this.Explainability,
  });
}

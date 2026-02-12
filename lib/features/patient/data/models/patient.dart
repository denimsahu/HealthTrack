import 'package:hive/hive.dart';

part 'patient.g.dart';

@HiveType(typeId: 0)
class Patient extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  String gender;

  @HiveField(3)
  String contact;

  @HiveField(4)
  String notes;

  Patient({
    required this.name,
    required this.age,
    required this.gender,
    required this.contact,
    required this.notes,
  });
}

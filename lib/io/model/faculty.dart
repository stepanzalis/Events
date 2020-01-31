import 'package:hive/hive.dart';

part 'faculty.g.dart';

@HiveType(typeId: 1)
enum Faculty {
  @HiveField(0)
  Pdf,
  @HiveField(1)
  Prf,
  @HiveField(2)
  Fim,
  @HiveField(3)
  Ff,
  @HiveField(4)
  Uhk,
  @HiveField(5)
  All
}

const facultyString = <Faculty, String>{
  Faculty.Uhk: "Uhk",
  Faculty.Ff: "Ff",
  Faculty.Fim: "Fim",
  Faculty.Pdf: "Ff",
  Faculty.Prf: "Prf",
  Faculty.All: "All",
};

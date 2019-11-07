import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'faculty.dart';

@immutable
class FacultyValue extends Equatable {
  final String name;
  final Color color;
  final String logoAsset;

  const FacultyValue(this.name, this.color, {this.logoAsset});

  @override
  List<Object> get props => [name, color, logoAsset];
}

/*
extension FacultyProperties on Faculty {
  FacultyValue facultyProperties() {
    switch (this) {
      case Faculty.Ff:
        return FacultyValue("Filozofická fakulta", Color.fromARGB(255, 132, 189, 1));
      case Faculty.Pdf:
        return FacultyValue("Pedagogická fakulta", Color.fromARGB(255, 207, 34, 87));
      case Faculty.Fim:
        return FacultyValue("Fakulta informatiky a managemantu", Color.fromARGB(255, 82, 158, 239));
      case Faculty.Prf:
        return FacultyValue("Přirodovědecká fakulta", Color.fromARGB(255, 239, 162, 7));
      case Faculty.Uhk:
        return FacultyValue("Univerzita Hradec Králové", Color.fromARGB(0, 0, 0, 0));
    }
    return FacultyValue("Neznámé", Color.fromARGB(255, 255, 255, 255));
  }
}*/

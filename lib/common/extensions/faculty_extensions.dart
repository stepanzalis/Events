import 'dart:ui';

import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/io/model/faculty.dart';

extension FacultyExtensions on Faculty {
  Color facultyColor() {
    switch (this) {
      case Faculty.Fim:
        return FimColor;
      case Faculty.Ff:
        return FfColor;
      case Faculty.Pdf:
        return PdfColor;
      case Faculty.Prf:
        return PrfColor;
      default:
        return UhkColor;
    }
  }

  Color facultyBackgroundColor() {
    switch (this) {
      case Faculty.Fim:
        return FimBackgroundColor;
      case Faculty.Ff:
        return FfBackgroundColor;
      case Faculty.Pdf:
        return PdfBackgroundColor;
      case Faculty.Prf:
        return PrfBackgroundColor;
      default:
        return UhkBackgroundColor;
    }
  }

  String facultyLogo() {
    switch (this) {
      case Faculty.Fim:
        return "assets/icons/fim_logo.png";
      case Faculty.Ff:
        return "assets/icons/ff_logo.png";
      case Faculty.Pdf:
        return "assets/icons/pdf_logo.png";
      case Faculty.Prf:
        return "assets/icons/prf_logo.png";
      default:
        return "assets/icons/uhk_logo.png";
    }
  }

  String facultySymbol() {
    switch (this) {
      case Faculty.Fim:
        return "assets/icons/fim.svg";
      case Faculty.Ff:
        return "assets/icons/ff.svg";
      case Faculty.Pdf:
        return "assets/icons/pdf.svg";
      case Faculty.Prf:
        return "assets/icons/prf.svg";
      default:
        return "assets/icons/uhk.svg";
    }
  }
}

extension FacultyType on String {
  Faculty getFaculty() {
    switch (this) {
      case "fim":
        return Faculty.Fim;
      case "pdf":
        return Faculty.Pdf;
      case "ff":
        return Faculty.Ff;
      case "prf":
        return Faculty.Prf;
      default:
        return Faculty.Uhk;
    }
  }
}

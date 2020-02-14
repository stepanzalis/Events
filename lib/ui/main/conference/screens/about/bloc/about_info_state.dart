import 'package:flutter/cupertino.dart';

@immutable
class AboutInfoState {
  final String title;
  final String description;
  final String date;
  final bool isDescriptionExpanded;

  const AboutInfoState(
      {@required this.title,
      @required this.description,
      @required this.date,
      @required this.isDescriptionExpanded});

  factory AboutInfoState.empty() {
    return AboutInfoState(
        title: "", description: "", date: "", isDescriptionExpanded: false);
  }

  factory AboutInfoState.filled(String title, String description, String date) {
    return AboutInfoState(
        title: title,
        description: description,
        date: date,
        isDescriptionExpanded: false);
  }

  AboutInfoState update({
    bool expanded,
  }) {
    return copyWith(
        title: title,
        description: description,
        date: date,
        isDescriptionExpanded: expanded);
  }

  AboutInfoState copyWith(
      {final String title,
      final String description,
      final String date,
      final bool isDescriptionExpanded}) {
    return AboutInfoState(
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        isDescriptionExpanded:
            isDescriptionExpanded ?? this.isDescriptionExpanded);
  }

  @override
  String toString() {
    return 'AboutState{title: $title, description: $description, date: $date, isDescriptionExpanded: $isDescriptionExpanded}';
  }
}

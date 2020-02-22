import 'package:flutter/cupertino.dart';

@immutable
class AboutInfoState {
  final String title;
  final String description;
  final String date;
  final String url;
  final bool isDescriptionExpanded;

  const AboutInfoState(
      {@required this.title,
      @required this.description,
      @required this.date,
      @required this.url,
      @required this.isDescriptionExpanded});

  factory AboutInfoState.empty() {
    return AboutInfoState(
        title: "",
        description: "",
        date: "",
        url: "",
        isDescriptionExpanded: false);
  }

  factory AboutInfoState.filled(
      String title, String description, String url, String date) {
    return AboutInfoState(
        title: title,
        description: description,
        date: date,
        url: url,
        isDescriptionExpanded: false);
  }

  AboutInfoState update({
    bool expanded,
  }) {
    return copyWith(
        title: title,
        description: description,
        date: date,
        url: url,
        isDescriptionExpanded: expanded);
  }

  AboutInfoState copyWith(
      {final String title,
      final String description,
      final String date,
      final String url,
      final bool isDescriptionExpanded}) {
    return AboutInfoState(
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        url: url ?? this.url,
        isDescriptionExpanded:
            isDescriptionExpanded ?? this.isDescriptionExpanded);
  }

  @override
  String toString() {
    return 'AboutInfoState{title: $title, description: $description, date: $date, url: $url, isDescriptionExpanded: $isDescriptionExpanded}';
  }
}

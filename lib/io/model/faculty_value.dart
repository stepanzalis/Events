import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class FacultyValue extends Equatable {
  final String name;
  final Color color;
  final String logoAsset;

  const FacultyValue(this.name, this.color, {this.logoAsset});

  @override
  List<Object> get props => [name, color, logoAsset];
}

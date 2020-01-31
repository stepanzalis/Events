import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uhk_events/common/constants.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';
import 'package:uhk_events/io/model/faculty.dart';

class FilterFacultyButton extends StatelessWidget {
  final bool isActive;
  final Faculty faculty;

  const FilterFacultyButton({@required this.faculty, this.isActive = false});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Opacity(
          opacity: isActive ? 1 : 0.3,
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
                color: isActive ? faculty.facultyColor() : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: faculty.facultyColor(),
                  width: 2,
                )),
            child: Center(
              child: SvgPicture.asset(faculty.facultySymbol(),
                  color: isActive ? Colors.white : faculty.facultyColor()),
            ),
          ),
        ),
      );
}

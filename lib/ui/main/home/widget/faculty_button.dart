import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uhk_events/io/model/faculty.dart';
import 'package:uhk_events/common/extensions/faculty_extensions.dart';

class FilterFacultyButton extends StatelessWidget {
  final double buttonSize = 40;
  final bool isEnabled;
  final Faculty faculty;

  const FilterFacultyButton({@required this.faculty, this.isEnabled = false});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Opacity(
          opacity: isEnabled ? 1 : 0.3,
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
                color: isEnabled ? faculty.facultyColor() : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: faculty.facultyColor(),
                  width: 2,
                )),
            child: Center(
              child: SvgPicture.asset(faculty.facultySymbol(),
                  color: isEnabled ? Colors.white : faculty.facultyColor()),
            ),
          ),
        ),
      );
}

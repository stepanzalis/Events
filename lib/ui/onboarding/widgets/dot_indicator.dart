import 'package:flutter/material.dart';
import 'package:uhk_events/ui/shared/theme/colors.dart';

class DotIndicator extends StatelessWidget {
  final int pageLength;
  final int selectedPage;

  const DotIndicator({@required this.pageLength, @required this.selectedPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageLength,
        (index) => _Circle(index: index, selectedIndex: selectedPage),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final int index;
  final int selectedIndex;

  _Circle({@required this.index, this.selectedIndex});

  final double size = 10.0;
  final double spacing = 10.0;

  @override
  Widget build(BuildContext context) => Container(
        height: size,
        width: size + (2 * spacing),
        child: Center(
          child: Material(
            color: index == selectedIndex
                ? indicatorSelectedColor
                : indicatorNormalColor,
            type: MaterialType.circle,
            child: Container(
              width: size,
              height: size,
            ),
          ),
        ),
      );
}

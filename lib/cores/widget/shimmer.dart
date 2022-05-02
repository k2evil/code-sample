import 'package:flutter/material.dart';

class DummyText extends StatelessWidget {
  const DummyText({
    Key? key,
    this.lines: 2,
    this.lineHeight: 24,
    this.lineSpace: 16,
    this.borderRadius: 16,
  })  : assert(lines > 0),
        super(key: key);
  final int lines;
  final double lineHeight;
  final double lineSpace;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildDummyLines(),
    );
  }

  List<Widget> _buildDummyLines() {
    var children =
        new List<Widget>.filled(lines * 2 - 1, Container(), growable: false);
    for (int i = 0; i < children.length; i++) {
      if (i.isEven) {
        children[i] = FractionallySizedBox(
          widthFactor:
              (children.length > 1 && i == (children.length - 1)) ? 0.45 : 1.0,
          child: Container(
            width: double.infinity,
            height: lineHeight,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        );
      } else {
        children[i] = SizedBox(
          height: lineSpace,
        );
      }
    }
    return children;
  }
}

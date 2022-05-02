import 'dart:ui';

extension Convertor on String? {
  Color? toColorOrNull() {
    if(this == null) return null;
    try {
      var color = this!.replaceAll("#", "");
      if (color.length == 6) {
        return Color(int.parse("0xFF" + color));
      } else if (color.length == 8) {
        return Color(int.parse("0x" + color));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Color toColor(Color defaultValue) {
    return this.toColorOrNull() ?? defaultValue;
  }
}

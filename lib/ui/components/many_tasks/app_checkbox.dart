import 'package:flutter/material.dart';
import 'package:flutter_todo_app/ui/common/app_colors.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.isCritical = false,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final bool isCritical;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      side: BorderSide(
        color: isCritical
            ? context.appColorsTheme.colorRed
            : context.appColorsTheme.supportSeparator,
        width: 2.0,
      ),
      checkColor: context.appColorsTheme.backPrimary,
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return isCritical
              ? context.appColorsTheme.colorRed
              : context.appColorsTheme.colorGreen;
        }
        if (states.contains(WidgetState.disabled)) {
          return context.appColorsTheme.labelTertiary;
        }

        return isCritical
            ? context.appColorsTheme.colorRed.withOpacity(0.4)
            : context.appColorsTheme.colorWhite;
      }),
    );
  }
}

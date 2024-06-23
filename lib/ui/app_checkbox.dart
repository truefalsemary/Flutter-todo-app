import 'package:flutter/material.dart';

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
      activeColor: Colors.red,
      side: BorderSide(
        color: isCritical
            ? Theme.of(context).colorScheme.error
            : Theme.of(context)
                .colorScheme
                .tertiary, // Customize the border color here
        width: 2.0, // Adjust the border width if needed
      ),
      checkColor: Theme.of(context).colorScheme.primary,
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return isCritical
              ? Theme.of(context).colorScheme.error
              // TODO(TrueFalseMary): вынести в тему
              : const Color(0xFF34C759);
        }
        if (states.contains(WidgetState.disabled)) {
          return Theme.of(context).colorScheme.tertiary;
        }

        return isCritical
            ? Theme.of(context).colorScheme.error.withOpacity(0.4)
            : Theme.of(context).colorScheme.primary;
      }),
    );
  }
}

part of '../../screens/task_screen.dart';

class _PrioritySection extends StatelessWidget {
  const _PrioritySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.appLn.priorityText, style: AppFonts.b2),
        DropdownButton<Importance>(
          dropdownColor: context.appColorsTheme.backPrimary,
          iconSize: 0.0,
          value: context.watch<OneTaskNotifier>().todo.importance,
          items: Importance.values
              .map<DropdownMenuItem<Importance>>((Importance value) {
            if (value == Importance.important) {
              return DropdownMenuItem<Importance>(
                value: value,
                child: Text(
                  value.parseToString(context),
                  style: TextStyle(color: context.appColorsTheme.colorRed),
                ),
              );
            }
            return DropdownMenuItem<Importance>(
              value: value,
              child: Text(value.parseToString(context)),
            );
          }).toList(),
          onChanged: (priority) =>
              context.read<OneTaskNotifier>().onChangePriority(priority),
        ),
      ],
    );
  }
}

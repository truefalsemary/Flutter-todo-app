part of '../../screens/task_screen.dart';

class _PrioritySection extends StatelessWidget {
  const _PrioritySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Важность', style: AppFonts.b2),
        DropdownButton<Priority>(
          dropdownColor: context.appColors.backPrimary,
          iconSize: 0.0,
          value: context.watch<OneTaskNotifier>().todo.priority,
          items:
              Priority.values.map<DropdownMenuItem<Priority>>((Priority value) {
            if (value == Priority.high) {
              return DropdownMenuItem<Priority>(
                value: value,
                child: Text(
                  value.parseToString(),
                  style: TextStyle(color: context.appColors.colorRed),
                ),
              );
            }
            return DropdownMenuItem<Priority>(
              value: value,
              child: Text(value.parseToString()),
            );
          }).toList(),
          onChanged: (priority) =>
              context.read<OneTaskNotifier>().onChangePriority(priority),
        ),
      ],
    );
  }
}

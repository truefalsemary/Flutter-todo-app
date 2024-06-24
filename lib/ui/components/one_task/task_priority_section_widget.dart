part of '../../screens/task_screen.dart';

class _PrioritySection extends StatelessWidget {
  const _PrioritySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Важность',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        DropdownButton<Priority>(
          iconSize: 0.0,
          value: context.watch<OneTaskNotifier>().todo.priority,
          items:
          Priority.values.map<DropdownMenuItem<Priority>>((Priority value) {
            if (value == Priority.high) {
              return DropdownMenuItem<Priority>(
                value: value,
                child: Text(
                  value.parseToString(),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
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
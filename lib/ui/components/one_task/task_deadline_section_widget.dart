part of '../../screens/task_screen.dart';

class _DeadlineSection extends StatelessWidget {
  const _DeadlineSection();

  @override
  Widget build(BuildContext context) {
    final readTodoNotifier = context.read<OneTaskNotifier>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Сделать до',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              formatDate(context.watch<OneTaskNotifier>().todo.deadline) ?? '',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        Switch(
            activeColor: Theme.of(context).colorScheme.secondary,
            value: context.watch<OneTaskNotifier>().todo.deadline != null,
            onChanged: (value) async {
              if (!value) {
                return readTodoNotifier.onChangeDeadline(null);
              } else {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  readTodoNotifier.onChangeDeadline(pickedDate);
                }
              }
              value = !value;
            }),
      ],
    );
  }

  String? formatDate(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat('dd MMMM yyyy').format(dateTime);
    }
    return null;
  }
}

class _DeleteSection extends StatelessWidget {
  const _DeleteSection({
    required this.isNew,
  });

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Visibility(
        visible: !isNew,
        child: TextButton.icon(
            onPressed: () {
              context
                  .read<ManyTasksBloc>()
                  .add(ManyTasksDeleted(context.read<OneTaskNotifier>().todo));
              Navigator.maybePop(context);
            },
            label: Text(
              'Удалить',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            )),
      ),
    );
  }
}

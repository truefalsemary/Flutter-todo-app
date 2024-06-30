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
            const Text(
              'Сделать до',
              style: AppFonts.b2,
            ),
            Text(
              DateFormatters.formatDate(
                      context.watch<OneTaskNotifier>().todo.deadline) ??
                  '',
              style: TextStyle(color: context.appColorsTheme.colorBlue),
            ),
          ],
        ),
        Switch(
            activeColor: context.appColorsTheme.colorBlue,
            value: context.watch<OneTaskNotifier>().todo.deadline != null,
            onChanged: (value) async {
              if (!value) {
                return readTodoNotifier.onChangeDeadline(null);
              } else {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate:
                      DateTime.now().add(const Duration(days: 365 * 1000)),
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

// String? formatDate(DateTime? dateTime) {
//   if (dateTime != null) {
//     return DateFormat('dd MMMM yyyy').format(dateTime);
//   }
//   return null;
// }
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
            onPressed: () => _deleteTask(context),
            label: Text(
              'Удалить',
              style: TextStyle(color: context.appColorsTheme.colorRed),
            ),
            icon: Icon(
              Icons.delete,
              color: context.appColorsTheme.colorRed,
            )),
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    context
        .read<TasksBloc>()
        .add(OneTaskDeleted(context.read<OneTaskNotifier>().todo.id));
    Navigator.maybePop(context);
  }
}

part of '../../screens/main_screen.dart';

class _DismissibleTodoListTile extends StatelessWidget {
  const _DismissibleTodoListTile(this.todo);

  final TodoEntity todo;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<int>(todo.id),
      background: ColoredBox(
        color: Colors.green,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      secondaryBackground: ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      child: _TodoListTile(todo: todo),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Меняем состояние `isCompleted` класса Todo
          context.read<ManyTasksBloc>().add(ManyTasksCompleted(todo));
          return false;
        } else if (direction == DismissDirection.endToStart) {
          // Удаляем запись
          context.read<ManyTasksBloc>().add(ManyTasksDeleted(todo));
          return true;
        }
        return null;
      },
    );
  }
}

class _TodoListTile extends StatelessWidget {
  const _TodoListTile({required this.todo});

  final TodoEntity todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AppMaterialWrapper(
            child: AppCheckbox(
              value: todo.isCompleted,
              isCritical: todo.priority == Priority.high,
              onChanged: (value) => context.read<ManyTasksBloc>().add(
                    ManyTasksCompleted(todo),
                  ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            todo.description,
            style: TextStyle(
              decoration: todo.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              decorationColor: todo.isCompleted
                  ? Theme.of(context)
                      .colorScheme
                      .tertiary // Change this to your desired line color
                  : Colors.transparent,
            ),
          )),
          AppMaterialWrapper(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.pushNamed(
                context,
                TaskScreen.routeName,
                arguments: todo,
              ),
              icon: const Icon(Icons.info_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

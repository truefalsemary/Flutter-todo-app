part of '../../screens/main_screen.dart';

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget(this.state);

  final ManyTasksState state;

  @override
  Widget build(BuildContext context) {
    if (state is ManyTasksSuccess) {
      final successState = state as ManyTasksSuccess;

      return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          sliver: DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            sliver: SliverPadding(
              padding: const EdgeInsets.only(top: 4),
              sliver: Builder(
                builder: (context) {
                  final filteredTodos = successState.showCompleted
                      ? successState.todos
                      : successState.todos.where((todo) => !todo.isCompleted);
                  return SliverList.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) => _DismissibleTodoListTile(
                      filteredTodos.elementAt(index),
                    ),
                  );
                },
              ),
            ),
          ));
    }
    return const SliverToBoxAdapter(
      child: Placeholder(),
    );
  }
}

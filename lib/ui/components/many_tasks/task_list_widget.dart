part of '../../screens/main_screen.dart';

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget(this.state);

  final AllTasksState state;

  @override
  Widget build(BuildContext context) {
    if (state is TasksSuccess) {
      final successState = state as TasksSuccess;

      return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          sliver: DecoratedSliver(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  offset: Offset.zero,
                  color: context.appColorsTheme.supportOverlay.withOpacity(0.06),
                  blurRadius: 2,
                ),
                BoxShadow(
                  offset: const Offset(0, 2),
                  color: context.appColorsTheme.supportOverlay.withOpacity(0.12),
                  blurRadius: 2,
                )
              ],
            ),
            sliver: SliverPadding(
              padding: const EdgeInsets.only(top: 4),
              sliver: Builder(
                builder: (context) {
                  final filteredTodos = successState.showCompleted
                      ? successState.cachedTasks
                      : successState.cachedTasks.where((todo) => !todo.isCompleted);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/data/todo_entity.dart';
import 'package:flutter_todo_app/domain/many_todos_bloc/many_todos_bloc.dart';
import 'package:flutter_todo_app/ui/app_checkbox.dart';
import 'package:flutter_todo_app/ui/app_material_wrapper.dart';
import 'package:flutter_todo_app/ui/todo_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<ManyTodosBloc, ManyTodosState>(
          builder: (BuildContext context, ManyTodosState state) {
        return Scaffold(
          // No appbar provided to the Scaffold, only a body with a
          // CustomScrollView.
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: MySliverPersistentHeaderDelegate(
                  minExtent: 130.0,
                  maxExtent: 148.0,
                  state: state,
                ),
              ),
              _TaskListWidget(state),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(
              context,
              TodoScreen.routeName,
            ),
            child: const Icon(Icons.add),
          ),
        );
      });
    });

    // ),
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate({
    required double minExtent,
    required double maxExtent,
    required this.state,
  })  : _minExtent = minExtent,
        _maxExtent = maxExtent;

  final double _minExtent;
  final double _maxExtent;

  final ManyTodosState state;

  @override
  double get minExtent => _minExtent;

  @override
  double get maxExtent => _maxExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    if (overlapsContent || shrinkOffset > 0.5) {
      return SizedBox(
        height: 88,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onPrimary,
                blurRadius: 10,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, right: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Мои дела',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                if (state is ManyTodosSuccess)
                  IconButton(
                    onPressed: () => context.read<ManyTodosBloc>().add(
                        ManyTodosFilter(
                            !(state as ManyTodosSuccess).showCompleted)),
                    icon: Icon(
                      (state as ManyTodosSuccess).showCompleted
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(
        top: 58,
        left: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Мои дела',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (state is ManyTodosSuccess)
                  Text(
                    'Выполнено — ${(state as ManyTodosSuccess).todos.where((todo) => todo.isCompleted).length}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                IconButton(
                  onPressed: () => context.read<ManyTodosBloc>().add(
                      ManyTodosFilter(
                          !(state as ManyTodosSuccess).showCompleted)),
                  icon: Icon(
                    (state as ManyTodosSuccess).showCompleted
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant MySliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.state != state;
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget(this.state);

  final ManyTodosState state;

  @override
  Widget build(BuildContext context) {
    if (state is ManyTodosSuccess) {
      final successState = state as ManyTodosSuccess;

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
          context.read<ManyTodosBloc>().add(ManyTodosCompleted(todo));
          return false;
        } else if (direction == DismissDirection.endToStart) {
          // Удаляем запись
          context.read<ManyTodosBloc>().add(ManyTodosDeleted(todo));
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
              onChanged: (value) => context.read<ManyTodosBloc>().add(
                    ManyTodosCompleted(todo),
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
                TodoScreen.routeName,
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

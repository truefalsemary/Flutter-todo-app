import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/todo_entity.dart';
import 'package:flutter_todo_app/domain/many_todos_bloc/many_todos_bloc.dart';
import 'package:flutter_todo_app/domain/todo_bloc/one_todo_notifier.dart';
import 'package:flutter_todo_app/ui/app_material_wrapper.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  static const routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo?;

    return ChangeNotifierProvider<TodoNotifier>(
      create: (_) {
        final manyState = context.read<ManyTodosBloc>().state;
        if (todo != null) {
          return TodoNotifier(id: todo.id, todo: todo);
        }
        if (manyState is ManyTodosSuccess) {
          return TodoNotifier(id: manyState.todos.length);
        }
        return TodoNotifier(id: 0);
      },
      child: Builder(builder: (context) {
        final readTodoNotifier = context.read<TodoNotifier>();
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
                leading: AppMaterialWrapper(
                    child: IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(Icons.close))),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      final todo = context.read<TodoNotifier>().todo;
                      return context
                          .read<ManyTodosBloc>()
                          .add(ManyTodosSaved(todo));
                    },
                    child: const Text('СОХРАНИТЬ'),
                  ),
                ]),
            body: todo == null
                ? const Center(child: Text('Ничего нету :('))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary,
                                  blurRadius: 2,
                                ),
                              ]),
                          child: TextField(
                            minLines: 5,
                            onChanged:
                                context.read<TodoNotifier>().onChangeText,
                            controller: context
                                .read<TodoNotifier>()
                                .textEditingController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                  // Radius.zero,
                                ),
                              ),
                              hintText: 'Что надо сделать...',
                              constraints: const BoxConstraints(
                                minHeight: 104,
                              ),
                              fillColor:
                                  Theme.of(context).colorScheme.onSecondary,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          'Важность',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),

                        DropdownButton<Priority>(
                          iconSize: 0.0,
                          value: context.watch<TodoNotifier>().todo.priority,
                          items: Priority.values
                              .map<DropdownMenuItem<Priority>>(
                                  (Priority value) {
                            if (value == Priority.high) {
                              return DropdownMenuItem<Priority>(
                                value: value,
                                child: Text(
                                  value.parseToString(),
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              );
                            }
                            return DropdownMenuItem<Priority>(
                              value: value,
                              child: Text(value.parseToString()),
                            );
                          }).toList(),
                          onChanged: (priority) => context
                              .read<TodoNotifier>()
                              .onChangePrority(priority),
                        ),
                        // child: Text(context
                        //     .watch<TodoNotifier>()
                        //     .todo
                        //     .priority
                        //     .parseToString())),
                        // Divider(color: Colors.grey.withOpacity(0.4)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Сделать до',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Switch(
                                activeColor:
                                    Theme.of(context).colorScheme.secondary,
                                value: context
                                        .watch<TodoNotifier>()
                                        .todo
                                        .deadline !=
                                    null,
                                onChanged: (value) async {
                                  if (value) {
                                    return context
                                        .read<TodoNotifier>()
                                        .onChangeDeadline(null);
                                  } else {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );

                                    if (pickedDate != null) {
                                      readTodoNotifier
                                          .onChangeDeadline(pickedDate);
                                    }
                                  }
                                }),
                          ],
                        ),
                        // DropdownButton(items: items, onChanged: onChanged),
                      ],
                    ),
                  ));
      }),
    );
  }
}

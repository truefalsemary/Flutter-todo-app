import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/todo_entity.dart';
import 'package:flutter_todo_app/domain/many_todos_bloc/many_todos_bloc.dart';
import 'package:flutter_todo_app/ui/app_material_wrapper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../domain/todo_notifier/one_todo_notifier.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  static const routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo?;
    final isNew = todo == null;

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
        final watchTodoNotifier = context.watch<TodoNotifier>();

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
                      context.read<ManyTodosBloc>().add(ManyTodosSaved(todo));
                      Navigator.maybePop(context);
                    },
                    child: const Text('СОХРАНИТЬ'),
                  ),
                ]),
            body: Padding(
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
                        const Divider(color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Сделать до',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  formatDate(watchTodoNotifier.todo.deadline) ??
                                      '',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
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
                                  if (!value) {
                                    return readTodoNotifier
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
                                  value = !value;
                                }),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Divider(color: Colors.grey),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Visibility(
                            visible: !isNew,
                            child: TextButton.icon(
                                onPressed: () {

                                  context.read<ManyTodosBloc>().add(
                                      ManyTodosDeleted(watchTodoNotifier.todo));
                                  Navigator.maybePop(context);
                                },
                                label: Text(
                                  'Удалить',
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.error),
                                ),
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).colorScheme.error,
                                )),
                          ),
                        ),
                        // DropdownButton(items: items, onChanged: onChanged),
                      ],
                    ),
                  ));
      }),
    );
  }

  String? formatDate(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat('dd MMMM yyyy').format(dateTime);
    }
    return null;
  }
}

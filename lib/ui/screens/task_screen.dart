import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:flutter_todo_app/ui/components/app_material_wrapper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/many_tasks_bloc/many_tasks_bloc.dart';
import '../../domain/task_notifier/one_task_notifier.dart';

part '../components/one_task/task_description_widget.dart';

part '../components/one_task/task_priority_section_widget.dart';

part '../components/one_task/task_deadline_section_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  static const routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as TodoEntity?;
    final isNew = todo == null;

    return ChangeNotifierProvider<OneTaskNotifier>(
      create: (_) {
        final manyState = context.read<ManyTasksBloc>().state;

        if (todo != null) {
          return OneTaskNotifier(id: todo.id, todo: todo);
        }
        if (manyState is ManyTasksSuccess) {
          return OneTaskNotifier(id: manyState.todos.length);
        }
        return OneTaskNotifier(id: 0);
      },
      child: Builder(builder: (context) {
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
                      final todo = context.read<OneTaskNotifier>().todo;
                      context.read<ManyTasksBloc>().add(ManyTasksSaved(todo));
                      Navigator.maybePop(context);
                    },
                    child: const Text('СОХРАНИТЬ'),
                  ),
                ]),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const _DescriptionTextField(),
                  const SizedBox(height: 28),
                  const _PrioritySection(),
                  const Divider(color: Colors.grey),
                  const _DeadlineSection(),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.grey),
                  _DeleteSection(isNew: isNew),
                ],
              ),
            ));
      }),
    );
  }
}

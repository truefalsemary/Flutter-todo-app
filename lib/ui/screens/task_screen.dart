import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:flutter_todo_app/ui/common/app_colors.dart';
import 'package:flutter_todo_app/ui/common/app_fonts.dart';
import 'package:flutter_todo_app/ui/components/app_material_wrapper.dart';
import 'package:flutter_todo_app/utils/date_formatters.dart';
import 'package:provider/provider.dart';

import '../../domain/task_notifier/task_notifier.dart';
import '../../domain/tasks_bloc/tasks_bloc.dart';

part '../components/one_task/task_description_widget.dart';

part '../components/one_task/task_priority_section_widget.dart';

part '../components/one_task/task_deadline_section_widget.dart';

class TaskScreenWrapper extends StatelessWidget {
  const TaskScreenWrapper({super.key});

  static const routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as TaskEntity?;
    final isNew = todo == null;

    return ChangeNotifierProvider<OneTaskNotifier>(
      create: (_) {
        final manyState = context.read<TasksBloc>().state;

        if (todo != null) {
          return OneTaskNotifier(id: todo.id, todo: todo);
        }
        if (manyState is TasksSuccess) {
          return OneTaskNotifier(id: manyState.tasks.length);
        }
        return OneTaskNotifier(id: 0);
      },
      child: _TaskScreenBody(
        taskEntity: todo,
        isNew: isNew,
      ),
    );
  }
}

class _TaskScreenBody extends StatelessWidget {
  const _TaskScreenBody({
    required this.taskEntity,
    required this.isNew,
  });

  final TaskEntity? taskEntity;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.appColors.backPrimary,
        appBar: AppBar(
            backgroundColor: context.appColors.backPrimary,
            leading: AppMaterialWrapper(
                child: IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.close))),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: context.appColors.colorBlue,
                ),
                onPressed: () => _saveTask(context),
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
              Divider(color: context.appColors.supportSeparator),
              const _DeadlineSection(),
              const SizedBox(height: 24),
              Divider(color: context.appColors.supportSeparator),
              _DeleteSection(isNew: isNew),
            ],
          ),
        ));
  }

  void _saveTask(BuildContext context) {
    final todo = context.read<OneTaskNotifier>().todo;
    context.read<TasksBloc>().add(OneTaskSaved(todo));
    Navigator.maybePop(context);
  }
}

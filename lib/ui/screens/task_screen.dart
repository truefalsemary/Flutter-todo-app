import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/task.dart';
import 'package:flutter_todo_app/ui/common/app_colors.dart';
import 'package:flutter_todo_app/ui/common/app_fonts.dart';
import 'package:flutter_todo_app/ui/components/app_material_wrapper.dart';
import 'package:flutter_todo_app/utils/date_formatters.dart';
import 'package:flutter_todo_app/utils/app_localization_context_ext.dart';
import 'package:provider/provider.dart';

import '../../data/importance_enum.dart';
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
    final todo = ModalRoute.of(context)!.settings.arguments as Task?;
    final isNew = todo == null;

    return ChangeNotifierProvider<OneTaskNotifier>(
      create: (_) {
        if (todo != null) {
          return OneTaskNotifier(todo: todo);
        }
        return OneTaskNotifier();
      },
      child: _TaskScreenBody(
        task: todo,
        isNew: isNew,
      ),
    );
  }
}

class _TaskScreenBody extends StatelessWidget {
  const _TaskScreenBody({
    required this.task,
    required this.isNew,
  });

  final Task? task;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.appColorsTheme.backPrimary,
        appBar: AppBar(
            backgroundColor: context.appColorsTheme.backPrimary,
            leading: AppMaterialWrapper(
                child: IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.close))),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: context.appColorsTheme.colorBlue,
                ),
                onPressed: () => _saveTask(context),
                child: Text(context.appLn.saveButton),
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const _DescriptionTextField(),
              const SizedBox(height: 28),
              const _PrioritySection(),
              Divider(color: context.appColorsTheme.supportSeparator),
              const _DeadlineSection(),
              const SizedBox(height: 24),
              Divider(color: context.appColorsTheme.supportSeparator),
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

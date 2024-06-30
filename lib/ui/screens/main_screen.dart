import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:flutter_todo_app/ui/common/app_colors.dart';
import 'package:flutter_todo_app/ui/common/app_fonts.dart';
import 'package:flutter_todo_app/ui/components/many_tasks/app_checkbox.dart';
import 'package:flutter_todo_app/ui/components/app_material_wrapper.dart';

import '../../domain/tasks_bloc/tasks_bloc.dart';
import 'task_screen.dart';
import 'dart:math' as math;

part '../components/many_tasks/main_screen_appbar.dart';

part '../components/many_tasks/task_list_widget.dart';

part '../components/many_tasks/dismissible_list_tile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, AllTasksState>(
        builder: (BuildContext context, AllTasksState state) {
      return Scaffold(
        backgroundColor: context.appColorsTheme.backPrimary,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _MainScreenSliverPersistentHeaderDelegate(
                topPadding: MediaQuery.of(context).padding.top,
                minExtent: 68.0,
                maxExtent: 140.0,
                state: state,
              ),
            ),
            _TaskListWidget(state),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
            context,
            TaskScreenWrapper.routeName,
          ),
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}

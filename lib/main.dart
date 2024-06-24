import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/ui/screens/main_screen.dart';
import 'package:flutter_todo_app/ui/screens/task_screen.dart';
import 'package:logging/logging.dart';

import 'data/tasks_repo.dart';
import 'domain/many_tasks_bloc/many_tasks_bloc.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName}: ${record.level.name}:  ${record.message}');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManyTasksBloc>(
      create: (_) =>
          ManyTasksBloc(MockTasksRepo())..add(const ManyTasksLoaded()),
      child: MaterialApp(
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          TaskScreen.routeName: (context) => const TaskScreen(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFFF7F6F2),
            onPrimary: Color(0xFF000000),
            // secondary: Color(0xFFFFFFFF),
            // onSecondary: Color(0x99000000),
            secondary: Color(0xFF007AFF),
            onSecondary: Color(0xFFFFFFFF),
            tertiary: Color(0x4D000000),
            error: Color(0xFFFF3B30),
            onError: Color(0xFFFFFFFF),
            surface: Color(0xFFF7F6F2),
            onSurface: Color(0xFF000000),
          ),

          // TODO(TrueFalseMary): подумать как лучше сделать тему с учетом критических заметок
          checkboxTheme: const CheckboxThemeData(),

          datePickerTheme: DatePickerThemeData(
            cancelButtonStyle: TextButton.styleFrom(
              foregroundColor: const Color(0xFF007AFF),
            ),
            confirmButtonStyle: TextButton.styleFrom(
              foregroundColor: const Color(0xFF007AFF),
            ),
          ),
          iconTheme: const IconThemeData(color: Color(0x4D000000)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF007AFF),
            foregroundColor: Color(0xFFFFFFFF),
            shape: CircleBorder(),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}

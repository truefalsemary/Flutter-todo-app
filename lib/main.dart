import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todo_app/ui/common/app_colors.dart';
import 'package:flutter_todo_app/ui/screens/main_screen.dart';
import 'package:flutter_todo_app/ui/screens/task_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'data/importance_enum.dart';
import 'data/repo/network_repo.dart';
import 'data/task_entity.dart';
import 'domain/tasks_bloc/tasks_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repo = DioRepo();

  const revision = 97;
  const add = false;
  const update = true;

  if (add) {
    repo.addTodo(
      todo: TaskEntity(
        id: '${revision+1}',
        text: 'text',
        importance: Importance.basic,
        createdAt: DateTime.now(),
        changedAt: DateTime.now(),
        lastUpdatedBy: 'macbook',
      ),
      revision: revision,
    );
  }

  if (update) {
    repo.updateTodos(
      tasks: [
        TaskEntity(
          id: '${revision*1000+1}',
          text: 'text',
          importance: Importance.basic,
          createdAt: DateTime(2023, 2, 1),
          changedAt: DateTime(2023, 3, 1),
          lastUpdatedBy: 'macbook',
        ),
        TaskEntity(
          id: '${revision*1000+2}',
          text: 'text',
          importance: Importance.basic,
          createdAt: DateTime(2023, 1, 1),
          changedAt: DateTime(2023, 2, 1),
          lastUpdatedBy: 'macbook',
        ),
        TaskEntity(
          id: '${revision*1000+3}',
          text: 'text',
          importance: Importance.basic,
          createdAt: DateTime(2023, 1, 1),
          changedAt: DateTime(2023, 6, 1),
          lastUpdatedBy: 'macbook',
        ),
      ],
      revision: revision,
    );
  }

  // await setUp();
  // runApp(const MyApp());
}

Future<void> setUp() async {
  // Инициализация логеров и установка их работы в дебаг режиме
  Logger.root.level = kDebugMode ? Level.ALL : Level.OFF;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.loggerName}: ${record.level.name}:  ${record.message}');
    }
  });

  // Создание локального хранилища
  final appDir = await getApplicationDocumentsDirectory();
  final storage = await HydratedStorage.build(
    storageDirectory: appDir,
  );
  HydratedBloc.storage = storage;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (_) => TasksBloc(DioRepo())..add(const AllTasksLoaded()),
      child: MaterialApp(
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          TaskScreenWrapper.routeName: (context) => const TaskScreenWrapper(),
        },
        title: 'Flutter Demo',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ru'), // Russian
        ],
        theme: ThemeData.light(useMaterial3: true).copyWith(
          // TODO(TrueFalseMary): подумать как лучше сделать тему с учетом критических заметок
          checkboxTheme: const CheckboxThemeData(),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColors.lightColorBlue,
            selectionHandleColor: AppColors.lightColorBlue,
          ),
          datePickerTheme: DatePickerThemeData(
            cancelButtonStyle: TextButton.styleFrom(
              foregroundColor: AppColors.lightColorBlue,
            ),
            confirmButtonStyle: TextButton.styleFrom(
              foregroundColor: AppColors.lightColorBlue,
            ),
            backgroundColor: AppColors.lightBackPrimary,
            dayStyle: const TextStyle(color: Colors.white),
            dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors
                    .lightColorBlue; // Change background color of selected day
              }
              return Colors
                  .transparent; // Background color of non-selected days
            }),
            todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors
                    .lightColorBlue; // Change background color of selected day
              }
              return Colors
                  .transparent; // Background color of non-selected days
            }),
            todayBorder: const BorderSide(color: AppColors.lightColorBlue),
          ),
          iconTheme: const IconThemeData(color: AppColors.lightLabelTertiary),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.lightColorBlue,
            foregroundColor: AppColors.lightBackPrimary,
            shape: CircleBorder(),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: AppColors.lightLabelPrimary),
            // isCollapsed: true,

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightSupportSeparator),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightSupportSeparator),
            ),
          ),
          extensions: <ThemeExtension>[AppColorsTheme.light()],
        ),
      ),
    );
  }
}

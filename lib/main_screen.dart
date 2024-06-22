import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/many_todos_bloc/many_todos_bloc.dart';
import 'package:flutter_todo_app/todo_repo.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManyTodosBloc>(
      create: (_) => ManyTodosBloc(MockTodosRepo())..add(const ManyTodosLoaded()),
      child: Scaffold(
        body: const Column(
          children: [
            TitleWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => (),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, top: 50, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Мои дела',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Выполнено',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: () => (),
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          const TaskListWidget(),
        ],
      ),
    );
  }
}

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManyTodosBloc, ManyTodosState>(
      builder: (BuildContext context, ManyTodosState state) {
        if (state is ManyTodosSuccess) {
          // return Text('data');
          return SizedBox(
            height: 200,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(state.todos[index].description),
                  value: state.todos[index].isCompleted,
                  onChanged: (_) => (),
                );
              },
            ),
          );
        }
        return const Placeholder();
      },
    );
  }
}

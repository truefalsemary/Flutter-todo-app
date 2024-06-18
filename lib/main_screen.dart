import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          const TitleWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => (),
        child: const Icon(Icons.add),
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
          )
        ],
      ),
    );
  }
}

// class TaskListWidget extends StatelessWidget {
//   const TaskListWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const ListView.builder(itemBuilder: itemBuilder);
//   }
// }


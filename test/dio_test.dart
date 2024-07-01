@Skip('тесты эндпоинтов бека')
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/data/importance_enum.dart';
import 'package:flutter_todo_app/data/repo/network_repo.dart';
import 'package:flutter_todo_app/data/task_entity.dart';

void main() {
  test('Get all todos', () async {
    final repo = DioRepo();
    expect(await repo.getAllTodos(), const TypeMatcher<List<TaskEntity>>());
  });

  test('Post new todo', () async {
    final taskEntity = TaskEntity(
      id: '19',
      text: 'text',
      importance: Importance.basic,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: 'macbook',
    );
    // print(taskEntity.toJson());
    final repo = DioRepo();
    final response = await repo.addTodo(
      revision: 25,
      todo: taskEntity,
    );
    expect(response.revision, 26);
  });

  // TODO(TrueFalseMary): дописать тесты для всех эндпоинтов и постави
  // final repo = DioRepo();

  // const revision = 28;
  // const add = false;
  // const update = true;
  //
  // if (add) {
  //   repo.addTodo(
  //     todo: TaskEntity(
  //       id: '${revision+1}',
  //       text: 'text',
  //       importance: Importance.basic,
  //       createdAt: DateTime.now(),
  //       changedAt: DateTime.now(),
  //       lastUpdatedBy: 'macbook',
  //     ),
  //     revision: revision,
  //   );
  // }
  //
  // if (update) {
  //   repo.updateTodos(
  //     tasks: [
  //       TaskEntity(
  //         id: '${revision*1000+1}',
  //         text: 'text',
  //         importance: Importance.basic,
  //         createdAt: DateTime(2023, 2, 1),
  //         changedAt: DateTime(2023, 3, 1),
  //         lastUpdatedBy: 'macbook',
  //       ),
  //       TaskEntity(
  //         id: '${revision*1000+2}',
  //         text: 'text',
  //         importance: Importance.basic,
  //         createdAt: DateTime(2023, 1, 1),
  //         changedAt: DateTime(2023, 2, 1),
  //         lastUpdatedBy: 'macbook',
  //       ),
  //       TaskEntity(
  //         id: '${revision*1000+3}',
  //         text: 'text',
  //         importance: Importance.basic,
  //         createdAt: DateTime(2023, 1, 1),
  //         changedAt: DateTime(2023, 6, 1),
  //         lastUpdatedBy: 'macbook',
  //       ),
  //     ],
  //     revision: revision,
  //   );
  // }
}

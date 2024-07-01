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
      id: '17',
      text: 'text',
      importance: Importance.basic,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: 'macbook',
    );
    // print(taskEntity.toJson());
    final repo = DioRepo();
    final response = await repo.addTodo(
      revision: 17,
      todo: taskEntity,
    );
    expect(response.revision, 18);
  });
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_todo_app/data/repo/tasks_repo.dart';
import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:logging/logging.dart';

// TODO(TrueFalseMary): сделать синглтоном через get it
class DioRepo extends TasksRepo {
  static final DioRepo _internalSingleton = DioRepo._internal();

  factory DioRepo() => _internalSingleton;

  DioRepo._internal({Dio? dio})
      : dio = (dio ?? Dio())
          ..options.baseUrl = 'https://beta.mrdekk.ru/todo'
          ..options.connectTimeout = const Duration(seconds: 15)
          ..options.receiveTimeout = const Duration(seconds: 30)
          ..interceptors.add(DioInterceptor())
          ..httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
            HttpClient client = HttpClient();
            client.badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
            return client;
          });

  late final _logger = Logger('DioRepo');
  final Dio dio;

  @override
  Future<({List<TaskEntity>? tasks, int? revision})> getAllTodos() async {
    final response = await dio.get('/list');
    if (response.statusCode == 200) {
      final body = response.data;
      final todos = (body['list'] as List)
          .map((json) => TaskEntity.fromJson(json as Map<String, dynamic>))
          .toList();
      final revision = body['revision'] as int;
      _logger.fine(() => 'get todos: $todos');
      return (tasks: todos, revision: revision);
    }
    return (tasks: null, revision: null);
  }

  @override
  Future<({int? revision})> addTodo({
    required TaskEntity todo,
    required int revision,
  }) async {
    dio.options.headers.addAll({"X-Last-Known-Revision": revision});
    _logger.fine(() => 'Sending request...');

    try {
      // _logger.info(() => json.encode(todo.toJson()));
      final response = await dio.post(
        '/list',
        data: jsonEncode({"element": todo}),
      );
      _logger.fine(() => 'Status code: ${response.statusCode}');
      final revision = response.data['revision'] as int;
      _logger.fine(() => 'Add todo: $todo}');
      return (revision: revision);
    } catch (e) {
      _logger.warning(() => 'Error occurred: $e');
    }
    return (revision: null);
  }

  @override
  Future<({int? revision})> deleteTodo(String id, {int? revision}) async {
    if (revision != null) {
      dio.options.headers.addAll({"X-Last-Known-Revision": revision});
      _logger.fine(() => 'Sending request...');
      try {
        final response = await dio.delete('/list/$id');
        _logger.fine(() => 'Status code: ${response.statusCode}');
        final revision = response.data['revision'] as int;
        _logger.fine(() => 'Delete todo by id: $id}');

        return (revision: revision);
      } catch (e) {
        _logger.warning(() => 'Error occurred: $e');
      }
    } else {
      _logger.warning(() => 'Revision is null');
    }
    return (revision: null);
  }

  @override
  Future<({int? revision})> updateTodo({
    required TaskEntity todo,
    required int revision,
  }) async {
    dio.options.headers.addAll({"X-Last-Known-Revision": revision});
    _logger.fine(() => 'Sending request...');

    try {
      _logger.info(() => json.encode(todo.toJson()));
      final response = await dio.put(
        '/list/${todo.id}',
        data: jsonEncode({"element": todo}),
      );
      _logger.fine(() => 'Status code: ${response.statusCode}');
      final revision = response.data['revision'] as int;
      _logger.fine(() => 'Update todo: $todo}');

      return (revision: revision);
    } catch (e) {
      _logger.warning(() => 'Error occurred: $e');
    }
    return (revision: null);
  }

  @override
  Future<({int? revision, List<TaskEntity>? tasks})> updateTodos(
      {required List<TaskEntity> tasks, required int revision}) async {
    dio.options.headers.addAll({"X-Last-Known-Revision": revision});
    _logger.fine(() => 'Sending request...');

    try {
      final data = jsonEncode({'list': tasks});
      _logger.fine('data: $data');
      final response = await dio.patch(
        '/list',
        data: jsonEncode({'list': tasks}),
      );
      _logger.fine(() => 'Status code: ${response.statusCode}');
      final revision = response.data['revision'] as int;
      // _logger.fine(() => 'Update todos` list: $todo}');

      return (revision: revision, tasks: tasks);
    } catch (e) {
      _logger.warning(() => 'Error occurred: $e');
    }
    return (revision: null, tasks: null);
  }
}

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"Content-Type": "application/json"});
    options.headers.addAll({"Authorization": "Bearer Carasgal"});
    return super.onRequest(options, handler);
  }
}

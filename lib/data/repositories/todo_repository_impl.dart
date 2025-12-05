import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource local;

  TodoRepositoryImpl({required this.local});

  @override
  Future<void> addTodo(Todo todo) async {
    final model = TodoModel(
      id: todo.id,
      title: todo.title,
      completed: todo.completed,
    );
    await local.addTodo(model);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await local.deleteTodo(id);
  }

  @override
  Future<List<Todo>> getTodos() async {
    final models = await local.fetchTodos();
    return models;
  }

  @override
  Future<void> toggleTodo(String id) async {
    final list = await local.fetchTodos();
    final idx = list.indexWhere((t) => t.id == id);
    if (idx >= 0) {
      final t = list[idx];
      final updated = TodoModel(
        id: t.id,
        title: t.title,
        completed: !t.completed,
      );
      await local.updateTodo(updated);
    }
  }
}

import 'dart:async';

import '../models/todo_model.dart';

/// Simple in-memory datasource. Replace with persistence (sqflite, hive, etc.) when needed.
class TodoLocalDataSource {
  final List<TodoModel> _store = [];

  Future<List<TodoModel>> fetchTodos() async {
    // simulate small delay
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_store);
  }

  Future<void> addTodo(TodoModel model) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _store.add(model);
  }

  Future<void> updateTodo(TodoModel model) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final idx = _store.indexWhere((t) => t.id == model.id);
    if (idx >= 0) {
      _store[idx] = model;
    }
  }

  Future<void> deleteTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _store.removeWhere((t) => t.id == id);
  }
}

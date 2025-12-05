import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/toggle_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final ToggleTodo toggleTodo;
  final DeleteTodo deleteTodo;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.toggleTodo,
    required this.deleteTodo,
  }) : super(TodoLoading()) {
    on<LoadTodos>(_onLoad);
    on<AddTodoEvent>(_onAdd);
    on<ToggleTodoEvent>(_onToggle);
    on<DeleteTodoEvent>(_onDelete);
  }

  Future<void> _onLoad(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await getTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError('Failed to load todos'));
    }
  }

  Future<void> _onAdd(AddTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        await addTodo(event.todo);
        final list = await getTodos();
        emit(TodoLoaded(list));
      } catch (_) {
        emit(TodoError('Failed to add todo'));
      }
    }
  }

  Future<void> _onToggle(ToggleTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        await toggleTodo(event.id);
        final list = await getTodos();
        emit(TodoLoaded(list));
      } catch (_) {
        emit(TodoError('Failed to toggle todo'));
      }
    }
  }

  Future<void> _onDelete(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        await deleteTodo(event.id);
        final list = await getTodos();
        emit(TodoLoaded(list));
      } catch (_) {
        emit(TodoError('Failed to delete todo'));
      }
    }
  }
}

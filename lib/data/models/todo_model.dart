import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required String id,
    required String title,
    bool completed = false,
  }) : super(id: id, title: title, completed: completed);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      completed: json['completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'completed': completed};
  }
}

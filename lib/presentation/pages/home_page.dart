import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(LoadTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Add a todo'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isEmpty) return;
                    final todo = Todo(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: text,
                    );
                    context.read<TodoBloc>().add(AddTodoEvent(todo));
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading)
                  return const Center(child: CircularProgressIndicator());
                if (state is TodoLoaded) {
                  final todos = state.todos;
                  if (todos.isEmpty)
                    return const Center(child: Text('No todos yet'));
                  return ListView.separated(
                    itemCount: todos.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final t = todos[index];
                      return ListTile(
                        title: Text(
                          t.title,
                          style: TextStyle(
                            decoration: t.completed
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        leading: Checkbox(
                          value: t.completed,
                          onChanged: (_) => context.read<TodoBloc>().add(
                            ToggleTodoEvent(t.id),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => context.read<TodoBloc>().add(
                            DeleteTodoEvent(t.id),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is TodoError)
                  return Center(child: Text(state.message));
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

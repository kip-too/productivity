import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/todo_providers.dart';
import '../widgets/add_todo_button.dart';
import '../widgets/todo_list_tile.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final ThemeData currentTheme = AppThemes.getCurrentTheme(isDarkMode);

    return MaterialApp(
      theme: currentTheme,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("ToDo List"),
          actions: [
            IconButton(
              icon: Icon(ref.read(isDarkModeProvider) ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                ref.read(isDarkModeProvider.notifier).toggleTheme();
              },
            ),
          ],
        ),
        body: _buildTodoList(ref),
        floatingActionButton: const AddTodoButton(),
      ),
    );
  }

  Widget _buildTodoList(WidgetRef ref) {
    final todosAsync = ref.watch(todoListProvider);
    return Consumer(
      builder: (context, WidgetRef ref, child) {
        return todosAsync.when(
          data: (todos) {
            print(todos);
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoListTile(
                  title: todos[index]['title'],
                  description: todos[index]['description'],
                  taskDone: todos[index]['taskDone'],
                  onCheckboxChanged: (value) {
                    // TODO: Update todo state
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text('Error fetching todos: $error'),
        );
      },
    );
  }
}


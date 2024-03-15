import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_app/core/constants/supabase_keys.dart';
import '../providers/todo_providers.dart';
import '../widgets/add_todo_button.dart';
import '../widgets/todo_list_tile.dart';
import 'todo_detail_page.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(todoListNotifierProvider.notifier).loadTodos();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ToDo List"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => ref.read(themeModeProvider.notifier).update(
                (state) => state == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light),
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode), // Access theme using Theme.of(context)
          ),
        ],
      ),
      drawer: _buildLogoutDrawer(context, ref),
      body: _buildTodoList(ref),
      floatingActionButton: const AddTodoButton(),
    );
  }

  Widget _buildLogoutDrawer(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          // Add other drawer items here if needed
          ListTile(
            title: const Text('Logout'),
            trailing: const Icon(Icons.logout),
            onTap: () async {
              final logoutResult = await _logout(ref);
              if (logoutResult) {
                // Navigate to login page or handle logout success
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              } else {
                // Handle logout failure (e.g., show an error message)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logout failed! Please try again.'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(WidgetRef ref) {
    final todos = ref.watch(todoListNotifierProvider);
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return GestureDetector(
          onTap: () {
            _navigateToDetailPage(context, todo);
          },
          child: TodoListTile(
            title: todo['title'],
            description: todo['description'],
            taskDone: todo['taskDone'],
          ),
        );
      },
    );
  }

  void _navigateToDetailPage(BuildContext context, Map<String, dynamic> todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoDetailPage(todo: todo),
      ),
    );
  }

  Future<bool> _logout(WidgetRef ref) async {
    try {
      await client.auth.signOut();
      return true; // Logout successful
    } catch (error) {
      print(error);
      return false; // Logout failed
    }
  }
}

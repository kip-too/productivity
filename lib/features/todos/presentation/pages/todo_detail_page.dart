import 'package:flutter/material.dart';
import '../../../../core/utils/db_helper.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/update_dialog.dart';

class TodoDetailPage extends StatelessWidget {
  final Map<String, dynamic> todo;

  const TodoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              todo['description'],
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the edit todo dialog
                    showDialog(
                      context: context,
                      builder: (context) => EditTodoDialog(todo: todo),
                    );
                  },
                  child: const Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await TodoDatabaseHelper().deleteTodo(todo['id']);
                    Navigator.pop(context);
                    CustomSnackBar.show(
                      context,
                      message: 'Todo deleted successfully!',
                      backgroundColor: Colors.green,
                    );
                  },
                  child: const Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await TodoDatabaseHelper().updateTodo({
                      'id': todo['id'],
                      'title': todo['title'],
                      'description': todo['description'],
                      'taskDone': true,
                    });
                    Navigator.pop(context);
                    CustomSnackBar.show(
                      context,
                      message: 'Todo marked as done!',
                      backgroundColor: Colors.green,
                    );
                  },
                  child: const Text('Mark as Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

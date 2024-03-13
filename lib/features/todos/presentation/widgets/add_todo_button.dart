import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_providers.dart';
import 'custom_snack_bar.dart';


class AddTodoButton extends ConsumerWidget {
  const AddTodoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        _showAddTodoDialog(context,ref);
      },
    );
  }

  void _showAddTodoDialog(BuildContext context,WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Todo'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Enter todo title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final String title = titleController.text.trim();
                if (title.isNotEmpty) {
                  await ref.read(todoListNotifierProvider.notifier).addTodo({
                    'title': title,
                    'description': '', // You can add a description here if needed
                    'taskDone': false,
                  });
                  Navigator.pop(context);
                  CustomSnackBar.show(
                    context,
                    message: 'Todo added successfully!',
                    backgroundColor: Colors.green,
                  );
                } else {
                  CustomSnackBar.show(
                    context,
                    message: 'Please enter a title',
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}



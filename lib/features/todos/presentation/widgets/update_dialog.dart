import 'package:flutter/material.dart';
import '../../../../core/utils/db_helper.dart';

class EditTodoDialog extends StatelessWidget {
  final Map<String, dynamic> todo;

  const EditTodoDialog({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String newTitle = todo['title'];
    String newDescription = todo['description'];

    return AlertDialog(
      title: const Text('Edit Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            onChanged: (value) {
              newTitle = value;
            },
            controller: TextEditingController(text: newTitle),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Description'),
            onChanged: (value) {
              newDescription = value;
            },
            controller: TextEditingController(text: newDescription),
          ),
        ],
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
            await TodoDatabaseHelper().updateTodo({
              'id': todo['id'], // Pass the todo ID
              'title': newTitle,
              'description': newDescription,
              'taskDone': todo['taskDone'],
            });
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}


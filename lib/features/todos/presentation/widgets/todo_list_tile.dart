import 'package:flutter/material.dart';

class TodoListTile extends StatefulWidget {
  final String title;
  final String description;
  late bool taskDone;
  final VoidCallback? onTap;

  TodoListTile({
    Key? key,
    required this.title,
    required this.description,
    required this.taskDone,
    this.onTap,
  }) : super(key: key);

  @override
  TodoListTileState createState() => TodoListTileState();
}

class TodoListTileState extends State<TodoListTile> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            ),
            subtitle: Text(widget.description,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal
              ),
            ),
            trailing: widget.taskDone
                ? Checkbox(
              value: widget.taskDone,
              onChanged: (newValue) {
                setState(() {
                  widget.taskDone = newValue!;
                });
              },
            )
                : null, // Show checkbox only when task is done
          ),
        ),
      ),
    );
  }
}

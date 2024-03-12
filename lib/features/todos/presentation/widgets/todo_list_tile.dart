import 'package:flutter/material.dart';

class TodoListTile extends StatefulWidget {
  final String title;
  final String description;
  late bool taskDone;
  final Function(bool)? onCheckboxChanged;

  TodoListTile({
    Key? key,
    required this.title,
    required this.description,
    required this.taskDone,
    this.onCheckboxChanged,
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
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColor, // Set color to primary color of the current theme
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          title: Text(widget.title),
          subtitle: Text(widget.description),
          trailing: Checkbox(
            value: widget.taskDone,
            onChanged: (newValue) {
              setState(() {
                widget.taskDone = newValue!;
                if (widget.onCheckboxChanged != null) {
                  widget.onCheckboxChanged!(newValue);
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

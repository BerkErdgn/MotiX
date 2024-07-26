import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:motix_app/pages/toDo/edit_todo_page.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  }) : super(key: key);

  final String taskName;
  final bool taskCompleted;
  final ValueChanged<bool?>? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext, String)? editFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: TodoItemPadding.itemPadding,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: TodoItemContainer(
          taskCompleted: taskCompleted,
          onChanged: onChanged,
          taskName: taskName,
          editFunction: editFunction,
        ),
      ),
    );
  }
}

class TodoItemContainer extends StatelessWidget {
  const TodoItemContainer({
    Key? key,
    required this.taskCompleted,
    required this.onChanged,
    required this.taskName,
    required this.editFunction,
  }) : super(key: key);

  final bool taskCompleted;
  final ValueChanged<bool?>? onChanged;
  final String taskName;
  final Function(BuildContext, String)? editFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: TodoItemPadding.containerPadding,
      decoration: BoxDecoration(
        color: const Color(0xFFfefae0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Checkbox(
            value: taskCompleted,
            onChanged: onChanged,
            checkColor: Colors.white,
            activeColor: Color(0xFFED7D31),
            side: const BorderSide(color: Colors.black),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              overflow: TextOverflow.ellipsis,
              taskName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: Colors.black,
                decorationThickness: 2,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              final editedTaskName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTodoPage(initialTaskName: taskName),
                ),
              );
              if (editedTaskName != null && editFunction != null) {
                editFunction!(context, editedTaskName);
              }
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}

class TodoItemPadding {
  static const EdgeInsets itemPadding =
      EdgeInsets.symmetric(vertical: 8, horizontal: 15);
  static const EdgeInsets containerPadding = EdgeInsets.all(20);
}

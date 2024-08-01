import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:motix_app/presantations/toDo/edit_todo_page.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final String taskName;
  final bool taskCompleted;
  final ValueChanged<bool?>? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext, String)? editFunction;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  _TodoItemState createState() => _TodoItemState();
} // end class TodoItem

class _TodoItemState extends State<TodoItem> {
  late bool _taskCompleted;

  @override
  void initState() {
    super.initState();
    _taskCompleted = widget.taskCompleted;
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _taskCompleted = value ?? false;
    });
    widget.onChanged?.call(value);
  }

  Future<void> _editTask(BuildContext context) async {
    final editedTaskName = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTodoPage(initialTaskName: widget.taskName),
      ),
    );
    if (editedTaskName != null && editedTaskName is String) {
      widget.editFunction?.call(context, editedTaskName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: TodoItemPadding.itemPadding,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
              backgroundColor: MotixColor.slidableDelete,
              borderRadius: BorderRadius.circular(15),
              label: TodoItemStrings.deleteAction,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: MotixColor.mainColorWhite,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TodoItemStrings.taskDetailsTitle,
                      style: TextStyle(color: MotixColor.mainColorDarkGrey),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit,
                          color: MotixColor.mainColorDarkGrey),
                      onPressed: () {
                        Navigator.pop(context);
                        _editTask(context);
                      },
                    ),
                  ],
                ),
                content: TodoItemDialog(
                  taskCompleted: _taskCompleted,
                  onChanged: _handleCheckboxChange,
                  taskName: widget.taskName,
                  date: widget.date,
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      TodoItemStrings.closeButton,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
          child: TodoItemContainer(
            taskCompleted: _taskCompleted,
            onChanged: _handleCheckboxChange,
            taskName: widget.taskName,
            editFunction: widget.editFunction,
            date: widget.date,
            startTime: widget.startTime,
            endTime: widget.endTime,
          ),
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
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final bool taskCompleted;
  final ValueChanged<bool?>? onChanged;
  final String taskName;
  final Function(BuildContext, String)? editFunction;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TodoItemPadding.containerPadding,
      decoration: BoxDecoration(
        color: MotixColor.mainColorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [],
      ),
      child: Row(
        children: [
          Checkbox(
            value: taskCompleted,
            onChanged: onChanged,

            checkColor: MotixColor.mainColorWhite,
            // Okey işareti rengi beyaz
            activeColor: MotixColor.mainColorOrange,
            // Kutunun işaretleninceki rengi turuncu
            fillColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return MotixColor.mainColorOrange; // İşaretlenmişse turuncu
              }
              return MotixColor.mainColorWhite; // İşaretlenmemişse beyaz
            }),
          ),
          Expanded(
            child: Text(
              taskName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                color: MotixColor.mainColorDarkGrey,
                decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: MotixColor.mainColorDarkGrey,
                decorationThickness: 2,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('dd-MM-yyyy').format(date),
                style: const TextStyle(color: MotixColor.mainColorDarkGrey),
              ),
              Text(
                '${startTime.format(context)} - ${endTime.format(context)}',
                style: const TextStyle(color: MotixColor.mainColorDarkGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
} // end class _TodoItemState

class TodoItemDialog extends StatefulWidget {
  const TodoItemDialog({
    Key? key,
    required this.taskCompleted,
    required this.onChanged,
    required this.taskName,
    required this.date,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final bool taskCompleted;
  final ValueChanged<bool?>? onChanged;
  final String taskName;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  _TodoItemDialogState createState() => _TodoItemDialogState();
} //end class TodoItemDialog

class _TodoItemDialogState extends State<TodoItemDialog> {
  late bool _taskCompleted;

  @override
  void initState() {
    super.initState();
    _taskCompleted = widget.taskCompleted;
  }

  void _handleCheckboxChange(bool? value) {
    //For checkbox change
    setState(() {
      _taskCompleted = value ?? false;
    });
    widget.onChanged?.call(value);
  } //end void _handleCheckboxChange

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Checkbox(
              value: _taskCompleted,
              onChanged: _handleCheckboxChange,
              checkColor: MotixColor.mainColorWhite,
              activeColor: MotixColor.mainColorOrange,
              fillColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return MotixColor.mainColorOrange;
                }
                return MotixColor.mainColorWhite;
              }),
            ),
            Expanded(
              child: Text(
                widget.taskName,
                style: TextStyle(
                  color: MotixColor.mainColorDarkGrey,
                  decoration:
                      _taskCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          DateFormat('dd-MM-yyyy').format(widget.date),
          style: const TextStyle(color: MotixColor.mainColorDarkGrey),
        ),
        Text(
          '${widget.startTime.format(context)} - ${widget.endTime.format(context)}',
          style: const TextStyle(color: MotixColor.mainColorDarkGrey),
        ),
      ],
    );
  }
} // end class _TodoItemDialogState

class TodoItemPadding {
  static const EdgeInsets itemPadding = EdgeInsets.symmetric(vertical: 5.0);
  static const EdgeInsets containerPadding = EdgeInsets.all(15.0);
} // end class TodoItemPadding

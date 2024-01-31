import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum TaskStatus { todo, inprogress, done }

class PopupMenuExample extends StatefulWidget {
  const PopupMenuExample({super.key, required this.documentReference});
  final DocumentSnapshot documentReference;
  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();
}

class _PopupMenuExampleState extends State<PopupMenuExample> {
  TaskStatus? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final String taskStatus = widget.documentReference["taskStatus"];
    return PopupMenuButton<TaskStatus>(
      icon: taskStatus == "TaskStatus.done"
          ? const Icon(
              Icons.check_box,
              color: Colors.green,
              size: 25,
            )
          : taskStatus == "TaskStatus.inprogress"
              ? const Icon(
                  Icons.bolt,
                  color: Colors.blue,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.red,
                ),
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (TaskStatus item) async {
        setState(() {
          selectedMenu = item;
        });

        await FirebaseFirestore.instance
            .collection("tasks")
            .doc(widget.documentReference.id)
            .update({"taskStatus": selectedMenu.toString()});
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<TaskStatus>>[
        const PopupMenuItem<TaskStatus>(
          value: TaskStatus.todo,
          child: Text('Todo'),
        ),
        const PopupMenuItem<TaskStatus>(
          value: TaskStatus.inprogress,
          child: Text('In Progress'),
        ),
        const PopupMenuItem<TaskStatus>(
          value: TaskStatus.done,
          child: Text('Done'),
        ),
      ],
    );
  }
}

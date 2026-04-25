import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
HomePage({super.key});

@override
State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
List<List> toDolist = [
['learn flutter', false],
['drink coffee', false],
];

// تغيير حالة المهمة (صح / غلط)
void checkBoxChanged(bool? value, int index) {
setState(() {
toDolist[index][1] = !toDolist[index][1];
});
}

// إضافة مهمة
void addTask(String task) {
setState(() {
toDolist.add([task, false]);
});
}

// حذف مهمة
void deleteTask(int index) {
setState(() {
toDolist.removeAt(index);
});
}

// Dialog لإضافة مهمة
void showAddDialog() {
String newTask = '';

showDialog(
  context: context,
  builder: (context) {
    return AlertDialog(
      title: const Text("Add Task"),
      content: TextField(
        onChanged: (value) {
          newTask = value;
        },
        decoration: const InputDecoration(
          hintText: "Enter task",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (newTask.isNotEmpty) {
              addTask(newTask);
            }
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    );
  },
);


}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.deepPurple.shade300,
appBar: AppBar(
title: const Text('Simple Todo'),
backgroundColor: Colors.deepPurple,
foregroundColor: Colors.white,
),


  // قائمة المهام
  body: ListView.builder(
    itemCount: toDolist.length,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Checkbox
            Checkbox(
              value: toDolist[index][1],
              onChanged: (value) =>
                  checkBoxChanged(value, index),
            ),

            // نص المهمة
            Expanded(
              child: Text(
                toDolist[index][0],
                style: TextStyle(
                  fontSize: 18,
                  decoration: toDolist[index][1]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),

            // زر الحذف
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTask(index),
            ),
          ],
        ),
      );
    },
  ),

  // زر إضافة مهمة
  floatingActionButton: FloatingActionButton(
    onPressed: showAddDialog,
    child: const Icon(Icons.add),
  ),
);

}
}

part of project_details;

class ProjectDetailsController extends GetxController {
  final List<String> statuses = ["To-Do", "Doing", "Done"];
  List<Task> tasksByStatus(String status) {
    return tasks.where((task) => task.status == status).toList();
  }
  void updateTaskStatus(int id, String newStatus) {
    int index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = tasks[index].copyWith(status: newStatus);
    }
  }
  var tasks = <Task>[
    Task(id: 1, title: "UI Design", description: "Design login page", status: "To-Do", dueDate: DateTime.now()),
    Task(id: 2, title: "Backend API", description: "Create task API", status: "Doing", dueDate: DateTime.now()),
    Task(id: 3, title: "Dataffffbase", description: "Design DB schema", status: "Done", dueDate: DateTime.now()),
  ].obs;

  // Move task between lists
  void moveTask(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    final movedTask = tasks
        .where((t) => t.status == statuses[oldListIndex])
        .toList()[oldItemIndex];

    tasks.remove(movedTask);

    movedTask.status = statuses[newListIndex];

    final newTasksInList = tasks
        .where((t) => t.status == statuses[newListIndex])
        .toList();

    if (newTasksInList.isEmpty) {
      tasks.add(movedTask);
    } else {
      int insertAt = tasks.indexOf(
        newTasksInList[newItemIndex < newTasksInList.length
            ? newItemIndex
            : newTasksInList.length - 1],
      );
      tasks.insert(insertAt, movedTask);
    }
    update(); // Notify UI
  }

  void addTask(String status, String title, String description, DateTime dueDate) {
    final newId = tasks.isEmpty ? 1 : tasks.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;
    tasks.add(Task(
      id: newId,
      title: title,
      description: description,
      status: status,
      dueDate: dueDate,
    ));
  }

  void deleteTask(int taskId) {
    tasks.removeWhere((task) => task.id == taskId);
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "To-Do":
        return Colors.blue;
      case "Doing":
        return Colors.orange;
      case "Done":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void showAddTaskDialog(BuildContext context, String status) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                  }
                },
                child: const Text("Pick Due Date"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    selectedDate != null) {
                  addTask(
                    status,
                    titleController.text,
                    descriptionController.text,
                    selectedDate!,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

}

part of project_details;

class ProjectDetailsController extends GetxController {
  //final List<String> statuses = ["To-Do", "Doing", "Done"];
  final List<int> statuses = [0, 1, 2]; // 0: To-Do, 1: Doing, 2: Done
  var http = HttpService();
  RxList<Tasks> tasks = <Tasks>[].obs;
  RxBool loading = false.obs;

  List<Tasks> tasksByStatus(int status) {
    return tasks.where((task) => task.status == status).toList();
  }

  void updateTaskStatus(int id, int newStatus) {
    int index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = tasks[index].copyWith(status: newStatus);
      tasks.refresh(); // Update UI
    }
  }


  late Projects project;

  @override
  void onInit() {
    super.onInit();

    project = Get.arguments as Projects;
    fetchData();
  }


  Future<void> fetchData() async {
    await fetchTasks();
  }

  Future<void> fetchTasks() async {
    loading.value = true;

    try {
      Map body = {"project_id": project.id};
      var res = await http.post(Get.context!, Api.getProjectTasks, body);
      if (res.statusCode == 200) {
        tasks.value = (jsonDecode(res.body) as List)
            .map((e) => Tasks.fromJson(e))
            .toList();
      } else {
        RequestHandler.errorRequest(Get.context!, message: res.body);
      }
    } catch (e) {
      print("ddd $e");
      Get.snackbar("Error", "Failed to fetch tasks");
    }

    loading.value = false;
  }

  String getStatusLabel(int status) {
    switch (status) {
      case 0:
        return "To-Do";
      case 1:
        return "Doing";
      case 2:
        return "Done";
      default:
        return "Unknown";
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }


  void showAddTaskDialog(BuildContext context, int status) {
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
              TextButton.icon(
                icon: const Icon(Icons.date_range),
                label: Text(selectedDate == null
                    ? "Pick Due Date"
                    : "Due: ${selectedDate?.toLocal().toString().split(' ')[0]}"),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    selectedDate != null) {
                  await addTaskToApi(
                    projectId: project.id!,
                    title: titleController.text,
                    description: descriptionController.text,
                    status: status,
                    dueDate: selectedDate!,
                    createdBy: 1, // Replace with real user ID later
                  );
                  Navigator.pop(context);
                } else {
                  Get.snackbar("Error", "Please fill all fields");
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
  Future<void> addTaskToApi({
    required int projectId,
    required String title,
    required String description,
    required int status,
    required DateTime dueDate,
    required int createdBy,
  }) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
      "title": title,
      "description": description,
      "status": status,
      "due_date": dueDate.toIso8601String(),
      "created_by": createdBy,
    };

    try {
      var res = await http.post(Get.context!, Api.addTask, body);
      if (res.statusCode == 200) {
        final task = Tasks.fromJson(jsonDecode(res.body));
        tasks.add(task);
        tasks.refresh(); // Update UI
        Get.snackbar("Success", "Task added successfully");
      } else {
        RequestHandler.errorRequest(Get.context!, message: res.body);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to add task");
    }
  }

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

  void addTask(
      int status,
      String title,
      String description,
      DateTime dueDate,
      ) {
    final newId = tasks.isEmpty
        ? 1
        : tasks.map((e) => e.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
    tasks.add(
      Tasks(
        id: newId,
        title: title,
        description: description,
        status: status,
        dueDate: dueDate,
      ),
    );
  }


  void deleteTask(int taskId) {
    tasks.removeWhere((task) => task.id == taskId);
  }


/*
  void showAddTaskDialog(BuildContext context, int status) {
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
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      selectedDate != null) {
                    addTask(
                      status, // now int
                      titleController.text,
                      descriptionController.text,
                      selectedDate!,
                    );
                    Navigator.pop(context);
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
  }*/

}

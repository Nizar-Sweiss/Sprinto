part of project_details;

class ProjectDetailsController extends GetxController {
  final List<int> statuses = [0, 1, 2]; // 0: To-Do, 1: Doing, 2: Done
  late Projects project;
  var http = HttpService.instance;
  RxList<Tasks> tasks = <Tasks>[].obs;
  RxBool loading = false.obs;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime? selectedDate;
  int? selectedStatus = 0;

  List<Tasks> tasksByStatus(int status) {
    return tasks.where((task) => task.status == status).toList();
  }

  @override
  void onInit() {
    super.onInit();
    project = Get.arguments as Projects;
    fetchTasks();
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
      Get.snackbar("Error", "Failed to fetch tasks");
    }

    loading.value = false;
  }

  Future<void> updateTaskStatus(int taskId, int newStatus) async {
    try {
      Map<String, dynamic> body = {"id": taskId, "status": newStatus};

      var res = await http.post(Get.context!, Api.updateTaskStatus, body);

      if (res.statusCode == 200) {
        // Update local task status
        int index = tasks.indexWhere((task) => task.id == taskId);
        if (index != -1) {
          tasks[index] = tasks[index].copyWith(status: newStatus);
          tasks.refresh();
        }
      } else {
        RequestHandler.errorRequest(Get.context!, message: res.body);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update task status");
    }
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

  Future<void> editTask(Tasks task) async {
    try {
      Map<String, dynamic> body = {
        "id": task.id,
        "title": task.title,
        "description": task.description,
        "status": task.status,
        "dueDate": task.dueDate?.toIso8601String(),
      };

      var res = await http.post(Get.context!, Api.editTask, body);

      if (res.statusCode == 200) {
        int index = tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          tasks[index] = task;
          tasks.refresh();
        }
        Get.snackbar("Success", "Task updated");
      } else {
        RequestHandler.errorRequest(Get.context!, message: res.body);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update task");
    }
  }

  void showTaskDialog({
    Tasks? task, // Null → Add, Non-null → Edit
    int? status, // Only needed for adding
  }) {
    titleController = TextEditingController(text: task?.title ?? '');
    descriptionController = TextEditingController(text: task?.description ?? '');
    selectedDate = task?.dueDate ?? DateTime.now();
    selectedStatus = task?.status ?? status ?? 0;

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title: Text(task == null ? "Add New Task" : "Edit Task",style: TextStyle(color: white),),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(title: "Title", hint: "Enter title", controller: titleController),
                    CustomTextField(title: "Description", hint: "Enter description", controller: descriptionController),


                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: selectedStatus,
                      items: const [
                        DropdownMenuItem(value: 0, child: Text("To-Do")),
                        DropdownMenuItem(value: 1, child: Text("Doing")),
                        DropdownMenuItem(value: 2, child: Text("Done")),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            selectedStatus = val;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.check_circle_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        filled: true,
                        fillColor: white,
                      ),
                      dropdownColor: white,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),

                    8.ph,
                    TextButton.icon(
                      icon: const Icon(Icons.date_range,color: white,),
                      label: Text(
                        selectedDate == null
                            ? "Pick Due Date"
                            : "Due: ${selectedDate?.toLocal().toString().split(' ')[0]}",
                        style: TextStyle(color: white),
                      ),
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel",style: TextStyle(color: Colors.white),),
            ),
            CustomButton(onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty &&
                  selectedDate != null) {
                if (task == null) {
                  // Add new task
                  await addTaskToApi(
                    projectId: project.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    status: selectedStatus!,
                    dueDate: selectedDate!,
                    createdBy: 1, // Replace with real user ID
                  );
                } else {
                  // Edit task
                  Tasks updatedTask = task.copyWith(
                    title: titleController.text,
                    description: descriptionController.text,
                    status: selectedStatus,
                    dueDate: selectedDate!,
                  );
                  await editTask(updatedTask);
                }

                // Clear & Close
                titleController.clear();
                descriptionController.clear();
                selectedDate = DateTime.now();
                selectedStatus = 0;
                Navigator.pop(context);
              } else {
                Get.snackbar("Error", "Please fill all fields");
              }
            },text: "Save",gradientColors: [secondaryColor,secondaryColor], ),

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

  void addTask(int status, String title, String description, DateTime dueDate) {
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

  Future<void> deleteTask(Tasks taskId) async {
    try {
      Map<String, dynamic> body = {
        "id": taskId.id,
        "project_id": taskId.projectId,
      };

      var res = await http.post(Get.context!, Api.deleteTask, body);

      if (res.statusCode == 200) {
        tasks.removeWhere((task) => task.id == taskId.id);
        tasks.refresh();
        Get.snackbar("Deleted", "Task deleted successfully");
      } else {
        RequestHandler.errorRequest(Get.context!, message: res.body);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to delete task");
    }
  }
}

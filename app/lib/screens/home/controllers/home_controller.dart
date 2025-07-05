part of home;

class HomeController extends GetxController {
  var http = HttpService();
  RxList<Projects> userProjects = <Projects>[].obs;
  RxBool loading = false.obs;

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  fetchData() async {
    switchLoading();
    await getProjects();
    switchLoading();
  }

  switchLoading() {
    loading.value = !loading.value;
  }

  Future<void> getProjects() async {
    Map body = {"created_by": 1};
    var res = await http.post(Get.context, Api.getUserProjects, body);

    if (res.statusCode == 200) {
      if (res.body.isNotEmpty) {
        userProjects.value = (jsonDecode(res.body) as List)
            .map((e) => Projects.fromJson(e))
            .toList();
      }
    } else {
      RequestHandler.errorRequest(Get.context!, message: res.body);
    }
  }

  Future<void> deleteProject(Projects project) async {
    var dialogRes = await Get.defaultDialog(
      title: "Delete Project",
      middleText: "Are you sure you want to delete this project?",
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Navigator.pop(Get.context!, true);
      },
    );
    if (dialogRes is bool && dialogRes) {
      Map body =  {"id": project.id, "title": project.title, "description": project.description};

      try {
        var res = await http.post(Get.context, Api.deleteProject, body);
        if (res.statusCode == 200) {
          userProjects.removeWhere((p) => p.id == project.id);
          Get.snackbar("Success", "Project deleted successfully");
        } else {
          RequestHandler.errorRequest(Get.context!, message: res.body);
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to delete project");
      }
    }
  }

  void showEditDialog(BuildContext context, Projects project) {
    final titleController = TextEditingController(text: project.title);
    final descriptionController = TextEditingController(
      text: project.description,
    );

    Get.dialog(
      AlertDialog(
        title: const Text("Edit Project"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              await editProject(
                project.id,
                titleController.text,
                descriptionController.text,
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> editProject(int id, String title, String description) async {
    Map body = {"id": id, "title": title, "description": description};
    var res = await http.post(Get.context, Api.editProject, body);
    if (res.statusCode == 200) {
      Get.back();
      await fetchData();
      Get.snackbar("Success", "Project updated successfully");
    } else {
      RequestHandler.errorRequest(Get.context!, message: res.body);
    }
  }

  void addProject() {
    Get.snackbar("Add", "Navigate to add new project");
  }
}

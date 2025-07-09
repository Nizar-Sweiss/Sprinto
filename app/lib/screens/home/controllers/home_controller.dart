part of home;

class HomeController extends GetxController {
  var http = HttpService.instance;
  var storage = StorageService.instance;

  RxList<Projects> userProjects = <Projects>[].obs;
  RxList<Projects> userProjectsTemp = <Projects>[].obs;
  RxBool loading = false.obs;

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var searchController = TextEditingController();
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
    Map body = {"created_by":storage.read('userId')};
    var res = await http.post(Get.context, Api.getUserProjects, body);

    if (res.statusCode == 200) {
      if (res.body.isNotEmpty) {
        userProjects.value = (jsonDecode(res.body) as List)
            .map((e) => Projects.fromJson(e))
            .toList();
        userProjectsTemp.value = userProjects.toList();
      }
    } else {
      RequestHandler.errorRequest(Get.context!, message: res.body);
    }
  }

  Future<void> deleteProject(Projects project) async {

    var dialogRes = await PopUps.askDialog(Icon(Icons.warning), "Delete Project", "Are you sure you want to delete this project?");

    if (dialogRes is bool && dialogRes) {
      Map body = {
        "id": project.id,
        "title": project.title,
        "description": project.description,
      };

      try {
        var res = await http.post(Get.context, Api.deleteProject, body);
        if (res.statusCode == 200) {
          userProjectsTemp.removeWhere((p) => p.id == project.id);
          Get.snackbar("Success", "Project deleted successfully",snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);
        } else {
          RequestHandler.errorRequest(Get.context!, message: res.body);
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to delete project",snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red);
      }
    }
  }

  void showEditDialog(BuildContext context, Projects? project, bool isAddNew) {
    if (!isAddNew) {
      titleController = TextEditingController(text: project!.title);
      descriptionController = TextEditingController(text: project.description);
    }

    Get.dialog(

      AlertDialog(
        backgroundColor: primaryColor,
        title: Text(isAddNew ? "Add Project" : "Edit Project",style: TextStyle(color: Colors.white),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(title: 'Title', hint: 'enter title', controller: titleController),

            const SizedBox(height: 12),
            CustomTextField(title: 'Description', hint: 'enter Description', controller: descriptionController),

          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel",style: TextStyle(color: Colors.white),)),
          CustomButton(text: "Save", onPressed: () async {
            if (isAddNew ) {
              if(titleController.text.isNotEmpty &&  descriptionController.text.isNotEmpty){
                addProject();
              }else{
                PopUps.showSnackBar(context, red, "Fill the fields to add new project!");
              }

            } else {
              await editProject(project!.id);
            }
            descriptionController.clear();
            titleController.clear();
          },gradientColors: [secondaryColor,secondaryColor],)

        ],
      ),
    );
  }

  Future<void> editProject(int id) async {
    Map body = {
      "id": id,
      "title": titleController.text,
      "description": descriptionController.text,
    };
    var res = await http.post(Get.context, Api.editProject, body);
    if (res.statusCode == 200) {
      Get.back();
      await fetchData();
      Get.snackbar("Success", "Project updated successfully",snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);
    } else {
      RequestHandler.errorRequest(Get.context!, message: res.body);
    }
  }

  void addProject() async {
    Map body = {
      "id": 0,
      "title": titleController.text,
      "description": descriptionController.text,
      "created_by": storage.read('userId'),
    };
    var res = await http.post(Get.context, Api.addProject, body);
    if (res.statusCode == 200) {
      Get.back();
      await fetchData();
      Get.snackbar("Success", "Project Added successfully",snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);
    } else {
      RequestHandler.errorRequest(Get.context!, message: res.body);
    }
  }

   onSearchBarChange() {
     if (searchController.text.isEmpty) {
       userProjectsTemp.value = userProjects.toList();
     } else {
       userProjectsTemp.value = userProjects.where(
             (element) {
               print( element.title.toLowerCase().contains(searchController.text.toLowerCase()));
               return element.title.toLowerCase().contains(searchController.text.toLowerCase());
             },
       ).toList();
     }

  }

  void onSearchBarClear() {
    searchController.clear();
    userProjectsTemp.value = userProjects.toList();

  }
}

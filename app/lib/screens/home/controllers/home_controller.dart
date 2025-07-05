part of home;

class HomeController extends GetxController {
  var http = HttpService();
  RxList<Projects> userProjects = <Projects>[].obs;
  RxBool loading = false.obs;

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

  void deleteProject(int id) {
    userProjects.removeWhere((p) => p.id == id);
  }

  void editProject(Projects project) {
    Get.snackbar("Edit", "Edit project: ${project.title}");
  }

  void addProject() {
    Get.snackbar("Add", "Navigate to add new project");
  }
}

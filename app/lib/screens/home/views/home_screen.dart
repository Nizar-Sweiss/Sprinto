// home_screen.dart
part of home;

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 800 ? 4
        : MediaQuery.of(context).size.width > 600 ? 3
        : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.userProjects.isEmpty) {
          return const Center(child: Text("No projects found."));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: controller.userProjects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                final project = controller.userProjects[index];
                return ProjectCard(
                  project: project,
                  onDelete: () => controller.deleteProject(project),
                  onEdit: () => controller.showEditDialog(context, project,false),
                );
              },
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.showEditDialog(context, null, true),
        icon: const Icon(Icons.add),
        label: const Text("Add Project"),
      ),
    );
  }
}

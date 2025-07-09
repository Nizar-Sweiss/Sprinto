// home_screen.dart
part of home;

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 4;

    return Scaffold(
      appBar: CustomAppBar(screenName: "Projects"),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    mutedPurple,
                    secondaryColor,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSearchBar(
                      controller: controller.searchController,
                      onChanged: (value) => controller.onSearchBarChange(),
                      onClear: () => controller.onSearchBarClear(),
                      showClearButton: true,
                    ),

                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: (controller.userProjectsTemp.isEmpty)
                            ? 1 // Only show add button if no projects
                            : controller.userProjectsTemp.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,

                        ),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () =>
                                  controller.showEditDialog(context, null, true),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey.shade400),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 50,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            final project =
                            controller.userProjectsTemp[index - 1];
                            return ProjectCard(
                              project: project,
                              onDelete: () => controller.deleteProject(project),
                              onEdit: () => controller.showEditDialog(
                                context,
                                project,
                                false,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),

    );
  }
}

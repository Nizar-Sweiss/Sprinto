part of project_details;

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectDetailsController controller = Get.put(
    ProjectDetailsController(),
  );

  ProjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(screenName: controller.project.title),
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor,
                mutedPurple,
                secondaryColor,
              ],
              begin: Alignment.centerRight,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: controller.statuses.map((status) {
                  final tasks = controller.tasksByStatus(status);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: 300, // Fixed width for better design
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: DragTarget<int>(
                        onAccept: (taskId) async {
                          await controller.updateTaskStatus(
                            taskId,
                            status,
                          );
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.getStatusLabel(status),
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: controller.getStatusColor(status),
                                      ),
                                ),
                                const SizedBox(height: 12),
                                TextButton.icon(
                                  onPressed: () =>
                                      controller.showTaskDialog(
                                        status: status,
                                      ),
                                  icon: const Icon(Icons.add),
                                  label: const Text("Add Task"),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: tasks.length,
                                    itemBuilder: (context, index) {
                                      final task = tasks[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: Draggable<int>(
                                          data: task.id!,
                                          feedback: SizedBox(
                                            width: 250,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Opacity(
                                                opacity: 0.85,
                                                child: TaskCard(task: task),
                                              ),
                                            ),
                                          ),
                                          childWhenDragging: Opacity(
                                            opacity: 0.3,
                                            child: TaskCard(task: task),
                                          ),
                                          child: TaskCard(task: task),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

part of project_details;

class TaskCard extends StatelessWidget {
  final Tasks task;
  final ProjectDetailsController controller =
      Get.find<ProjectDetailsController>();

  TaskCard({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(
          task.title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(task.description!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => controller.showEditTaskDialog(context, task),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: ()=> controller.deleteTask(task),
            ),
          ],
        ),
      ),
    );
  }
}

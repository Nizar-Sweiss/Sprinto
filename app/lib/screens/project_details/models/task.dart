// models/task.dart
class Task {
  final int id;
  final String title;
  final String description;
  late final String status; // "To Do", "In Progress", "Done"
  final DateTime dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
  });

  Task copyWith({String? status}) {
    return Task(
      id: id,
      title: title,
      description: description,
      status: status ?? this.status,
      dueDate: dueDate,
    );
  }
}
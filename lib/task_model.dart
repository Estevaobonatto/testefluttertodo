class Task {
  String id;
  String title;
  bool isCompleted;
  DateTime dueDate;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.dueDate,
  });

  // Você pode adicionar métodos aqui, como toJson(), fromJson(), etc.
}

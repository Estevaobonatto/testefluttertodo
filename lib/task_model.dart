import 'package:hive/hive.dart';

// Indica que este arquivo é parte de task_model.g.dart
part 'task_model.g.dart';

// Define a classe Task como um tipo Hive com ID 0
@HiveType(typeId: 0)
class Task extends HiveObject {
  // Define os campos da classe Task
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  String category;

  // Construtor da classe Task
  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.dueDate,
    required this.category,
  });
}

// Define a classe Category como um tipo Hive com ID 1
@HiveType(typeId: 1)
class Category extends HiveObject {
  // Define os campos da classe Category
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  // Construtor da classe Category
  Category({
    required this.id,
    required this.name,
  });
}

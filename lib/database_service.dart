import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'task_model.dart';

// Classe que gerencia as operações de banco de dados
class DatabaseService {
  // Constante que define o nome da caixa (box) para armazenar tarefas
  static const String tasksBoxName = 'tasks';
  // Constante que define o nome da caixa (box) para armazenar categorias
  static const String categoriesBoxName = 'categories';

  // Método estático para inicializar o banco de dados
  static Future<void> initDatabase() async {
    // Obtém o diretório de documentos do aplicativo
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    // Inicializa o Hive com o caminho do diretório de documentos
    await Hive.initFlutter(appDocumentDir.path);

    // Registra os adaptadores
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(CategoryAdapter());

    // Abre as caixas (boxes) para armazenar tarefas e categorias
    await Hive.openBox<Task>(tasksBoxName);
    await Hive.openBox<Category>(categoriesBoxName);
  }

  // Método estático para obter a caixa (box) de tarefas
  static Box<Task> getTasksBox() {
    return Hive.box<Task>(tasksBoxName);
  }

  // Método estático para obter a caixa (box) de categorias
  static Box<Category> getCategoriesBox() {
    return Hive.box<Category>(categoriesBoxName);
  }

  // Método estático para adicionar uma nova tarefa
  static Future<void> addTask(Task task) async {
    final box = getTasksBox();
    // Adiciona a tarefa à caixa, usando o ID da tarefa como chave
    await box.put(task.id, task);
  }

  // Método estático para atualizar uma tarefa existente
  static Future<void> updateTask(Task task) async {
    final box = getTasksBox();
    // Atualiza a tarefa na caixa, usando o ID da tarefa como chave
    await box.put(task.id, task);
  }

  // Método estático para excluir uma tarefa
  static Future<void> deleteTask(String taskId) async {
    final box = getTasksBox();
    // Remove a tarefa da caixa usando o ID da tarefa
    await box.delete(taskId);
  }

  // Método estático para obter todas as tarefas
  static List<Task> getAllTasks() {
    final box = getTasksBox();
    // Retorna uma lista com todos os valores (tarefas) da caixa
    return box.values.toList();
  }

  // Método estático para adicionar uma nova categoria
  static Future<void> addCategory(Category category) async {
    final box = getCategoriesBox();
    // Adiciona a categoria à caixa, usando o ID da categoria como chave
    await box.put(category.id, category);
  }

  // Método estático para excluir uma categoria
  static Future<void> deleteCategory(String categoryId) async {
    final box = getCategoriesBox();
    // Remove a categoria da caixa usando o ID da categoria
    await box.delete(categoryId);
  }

  // Método estático para obter todas as categorias
  static List<Category> getAllCategories() {
    final box = getCategoriesBox();
    // Retorna uma lista com todos os valores (categorias) da caixa
    return box.values.toList();
  }
}

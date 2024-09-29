import 'package:flutter/material.dart';
import 'task_model.dart';
import 'database_service.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);

  @override
  _TarefasPageState createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  List<Task> _tarefas = [];

  @override
  void initState() {
    super.initState();
    _loadTarefas();
  }

  void _loadTarefas() {
    setState(() {
      _tarefas = DatabaseService.getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tarefas.length,
      itemBuilder: (context, index) {
        final tarefa = _tarefas[index];
        return ListTile(
          title: Text(tarefa.title),
          subtitle: Text('Categoria: ${tarefa.category}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await DatabaseService.deleteTask(tarefa.id);
              _loadTarefas();
            },
          ),
        );
      },
    );
  }
}

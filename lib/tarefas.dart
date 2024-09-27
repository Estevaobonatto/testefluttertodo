import 'package:flutter/material.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);

  @override
  _TarefasPageState createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final List<String> _tarefas = ['Tarefa 1', 'Tarefa 2', 'Tarefa 3'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tarefas.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_tarefas[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _tarefas.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }
}

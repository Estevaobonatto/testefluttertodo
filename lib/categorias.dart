import 'package:flutter/material.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({Key? key}) : super(key: key);

  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  final List<String> _categorias = ['Trabalho', 'Pessoal', 'Estudos'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _categorias.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_categorias[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _categorias.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }
}

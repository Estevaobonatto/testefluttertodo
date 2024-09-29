import 'package:flutter/material.dart';
import 'task_model.dart';
import 'database_service.dart';
import 'package:uuid/uuid.dart';

// Define a classe CategoriasPage como um widget com estado
class CategoriasPage extends StatefulWidget {
  // Construtor da classe
  const CategoriasPage({Key? key}) : super(key: key);

  // Cria o estado para o widget
  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

// Define o estado para o widget CategoriasPage
class _CategoriasPageState extends State<CategoriasPage> {
  // Lista para armazenar as categorias
  List<Category> _categorias = [];

  // Método chamado quando o widget é inicializado
  @override
  void initState() {
    super.initState();
    _loadCategorias(); // Carrega as categorias ao iniciar
  }

  // Método para carregar as categorias do banco de dados
  void _loadCategorias() {
    setState(() {
      _categorias =
          DatabaseService.getAllCategories(); // Obtém todas as categorias
    });
  }

  // Método para construir a interface do widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: const Text('Categorias'), // Título da página
        actions: [
          // Botão para adicionar nova categoria
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                _addCategoria(), // Chama o método para adicionar categoria
          ),
        ],
      ),
      // Corpo da página com lista de categorias
      body: ListView.builder(
        itemCount: _categorias.length, // Número de itens na lista
        itemBuilder: (context, index) {
          final categoria = _categorias[index]; // Obtém a categoria atual
          return ListTile(
            title: Text(categoria.name), // Exibe o nome da categoria
            // Botão para excluir a categoria
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await DatabaseService.deleteCategory(
                    categoria.id); // Exclui a categoria
                _loadCategorias(); // Recarrega a lista de categorias
              },
            ),
          );
        },
      ),
    );
  }

  // Método para adicionar uma nova categoria
  void _addCategoria() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String novaCategoriaName = ''; // Armazena o nome da nova categoria
        return AlertDialog(
          title: const Text('Adicionar Categoria'), // Título do diálogo
          // Campo de texto para inserir o nome da categoria
          content: TextField(
            onChanged: (value) {
              novaCategoriaName = value; // Atualiza o nome da categoria
            },
            decoration: const InputDecoration(hintText: "Nome da categoria"),
          ),
          actions: <Widget>[
            // Botão para cancelar a adição
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            // Botão para confirmar a adição
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () async {
                if (novaCategoriaName.isNotEmpty) {
                  // Cria uma nova categoria
                  final novaCategoria = Category(
                    id: const Uuid().v4(), // Gera um ID único
                    name: novaCategoriaName, // Define o nome da categoria
                  );
                  await DatabaseService.addCategory(
                      novaCategoria); // Adiciona a categoria ao banco de dados
                  _loadCategorias(); // Recarrega a lista de categorias
                  Navigator.of(context).pop(); // Fecha o diálogo
                }
              },
            ),
          ],
        );
      },
    );
  }
}

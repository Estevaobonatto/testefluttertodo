// Importações necessárias para o funcionamento do aplicativo
import 'package:flutter/material.dart';
import 'tarefas.dart';
import 'calendario.dart';
import 'categorias.dart';
import 'configs.dart';
import 'task_model.dart';
import 'database_service.dart';
import 'package:uuid/uuid.dart';

// Definição da classe HomePage como um widget com estado
class HomePage extends StatefulWidget {
  // Função para alternar o tema, passada como parâmetro
  final Function(ThemeMode) toggleTheme;

  // Construtor da classe HomePage
  const HomePage({Key? key, required this.toggleTheme}) : super(key: key);

  // Cria o estado associado a este widget
  @override
  _HomePageState createState() => _HomePageState();
}

// Classe que representa o estado do widget HomePage
class _HomePageState extends State<HomePage> {
  // Índice da aba selecionada na barra de navegação inferior
  int _selectedIndex = 0;

  // Método para construir a interface do usuário
  @override
  Widget build(BuildContext context) {
    // Lista de widgets correspondentes a cada aba
    final List<Widget> _widgetOptions = <Widget>[
      const TarefasPage(),
      const CalendarioPage(),
      const CategoriasPage(),
      ConfigsPage(toggleTheme: widget.toggleTheme),
    ];

    // Estrutura principal da página
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: const Text('Minha Lista de Tarefas'),
      ),
      // Corpo principal da página, exibe o widget correspondente à aba selecionada
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // Itens da barra de navegação
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        // Cor do item selecionado
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        // Cor dos itens não selecionados
        unselectedItemColor:
            Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        // Função chamada ao tocar em um item da barra de navegação
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      // Botão flutuante para adicionar uma nova tarefa
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdicionarTarefaPage()),
          );
        },
        tooltip: 'Adicionar Tarefa',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Definição da classe AdicionarTarefaPage como um widget com estado
class AdicionarTarefaPage extends StatefulWidget {
  const AdicionarTarefaPage({Key? key}) : super(key: key);

  // Cria o estado associado a este widget
  @override
  _AdicionarTarefaPageState createState() => _AdicionarTarefaPageState();
}

// Classe que representa o estado do widget AdicionarTarefaPage
class _AdicionarTarefaPageState extends State<AdicionarTarefaPage> {
  // Chave global para o formulário
  final _formKey = GlobalKey<FormState>();
  // Variáveis para armazenar os dados da nova tarefa
  late String _titulo;
  late DateTime _dataVencimento;
  String? _categoria; // Nullable para permitir seleção opcional
  List<Category> _categorias = [];

  // Método chamado quando o widget é inicializado
  @override
  void initState() {
    super.initState();
    _dataVencimento = DateTime.now();
    _loadCategorias();
  }

  // Método para carregar as categorias do banco de dados
  void _loadCategorias() {
    setState(() {
      _categorias = DatabaseService.getAllCategories();
      if (_categorias.isNotEmpty) {
        _categoria = _categorias.first.name;
      }
    });
  }

  // Método para construir a interface do usuário
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'),
      ),
      // Corpo principal da página
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de texto para o título da tarefa
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
                onSaved: (value) {
                  _titulo = value!;
                },
              ),
              const SizedBox(height: 16),
              // Menu suspenso para selecionar a categoria
              DropdownButtonFormField<String>(
                value: _categoria,
                decoration: const InputDecoration(labelText: 'Categoria'),
                items: _categorias.map((Category category) {
                  return DropdownMenuItem<String>(
                    value: category.name,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _categoria = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione uma categoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Botão para selecionar a data de vencimento
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _dataVencimento,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _dataVencimento) {
                    setState(() {
                      _dataVencimento = picked;
                    });
                  }
                },
                child: Text(
                    'Data de Vencimento: ${_dataVencimento.toString().split(' ')[0]}'),
              ),
              const SizedBox(height: 16),
              // Botão para salvar a nova tarefa
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Cria uma nova tarefa com os dados fornecidos
                    final novaTarefa = Task(
                      id: const Uuid().v4(),
                      title: _titulo,
                      dueDate: _dataVencimento,
                      category: _categoria!,
                    );
                    // Adiciona a nova tarefa ao banco de dados
                    DatabaseService.addTask(novaTarefa);
                    // Retorna à página anterior
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar Tarefa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

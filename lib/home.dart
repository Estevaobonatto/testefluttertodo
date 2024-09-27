import 'package:flutter/material.dart';
import 'tarefas.dart';
import 'calendario.dart';
import 'categorias.dart';
import 'configs.dart';

class HomePage extends StatefulWidget {
  final Function(ThemeMode) toggleTheme;

  const HomePage({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const TarefasPage(),
      const CalendarioPage(),
      const CategoriasPage(),
      ConfigsPage(toggleTheme: widget.toggleTheme),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Lista de Tarefas'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor:
            Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
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

// Esta é uma página de exemplo para adicionar tarefa
class AdicionarTarefaPage extends StatelessWidget {
  const AdicionarTarefaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'),
      ),
      body: const Center(
        child: Text('Página para adicionar nova tarefa'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// Widget para a página de configurações
class ConfigsPage extends StatefulWidget {
  // Função para alternar o tema
  final Function(ThemeMode) toggleTheme;

  const ConfigsPage({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _ConfigsPageState createState() => _ConfigsPageState();
}

class _ConfigsPageState extends State<ConfigsPage> {
  // Variáveis de estado para as configurações
  bool _notificacoesAtivadas = true;
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Switch para ativar/desativar notificações
        SwitchListTile(
          title: const Text('Notificações'),
          value: _notificacoesAtivadas,
          onChanged: (bool value) {
            setState(() {
              _notificacoesAtivadas = value;
            });
          },
        ),
        // Switch para alternar entre tema claro e escuro
        ListTile(
          title: const Text('Tema'),
          subtitle: Text(_themeMode == ThemeMode.light ? 'Claro' : 'Escuro'),
          trailing: Switch(
            value: _themeMode == ThemeMode.dark,
            onChanged: (bool isDark) {
              setState(() {
                _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
                widget.toggleTheme(_themeMode);
              });
            },
          ),
        ),
      ],
    );
  }
}

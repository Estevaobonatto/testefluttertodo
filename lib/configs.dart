import 'package:flutter/material.dart';

class ConfigsPage extends StatefulWidget {
  final Function(ThemeMode) toggleTheme;

  const ConfigsPage({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _ConfigsPageState createState() => _ConfigsPageState();
}

class _ConfigsPageState extends State<ConfigsPage> {
  bool _notificacoesAtivadas = true;
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Notificações'),
          value: _notificacoesAtivadas,
          onChanged: (bool value) {
            setState(() {
              _notificacoesAtivadas = value;
            });
          },
        ),
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

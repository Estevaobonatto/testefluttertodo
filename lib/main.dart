import 'package:flutter/material.dart';
import 'home.dart';
import 'database_service.dart';

// Função principal que inicia o aplicativo
void main() async {
  // Garante que os widgets do Flutter estejam inicializados antes de executar o app
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa o banco de dados local
  await DatabaseService.initDatabase();
  // Executa o aplicativo, iniciando com o widget MyApp
  runApp(const MyApp());
}

// Widget principal do aplicativo, definido como StatefulWidget para permitir mudanças de estado
class MyApp extends StatefulWidget {
  // Construtor constante com parâmetro key opcional
  const MyApp({Key? key}) : super(key: key);

  // Cria o estado mutável para o widget
  @override
  _MyAppState createState() => _MyAppState();
}

// Estado do widget MyApp
class _MyAppState extends State<MyApp> {
  // Variável para controlar o tema atual do aplicativo
  ThemeMode _themeMode = ThemeMode.light;

  // Função para alternar entre temas claro e escuro
  void toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  // Método build que constrói a interface do usuário do widget
  @override
  Widget build(BuildContext context) {
    // Define as cores primárias para os temas claro e escuro
    const Color primaryColorLight =
        Color(0xFF6A1B9A); // Cor roxa para o tema claro
    const Color primaryColorDark =
        Color(0xFFAB47BC); // Cor roxa mais clara para o tema escuro

    // Retorna um widget MaterialApp, que configura o tema e a estrutura básica do app
    return MaterialApp(
      title: 'Meu App Flutter',
      // Configuração do tema claro
      theme: ThemeData(
        // Cria um MaterialColor baseado na cor primária do tema claro
        primarySwatch: MaterialColor(primaryColorLight.value, {
          50: primaryColorLight.withOpacity(0.1),
          100: primaryColorLight.withOpacity(0.2),
          200: primaryColorLight.withOpacity(0.3),
          300: primaryColorLight.withOpacity(0.4),
          400: primaryColorLight.withOpacity(0.5),
          500: primaryColorLight,
          600: primaryColorLight.withOpacity(0.7),
          700: primaryColorLight.withOpacity(0.8),
          800: primaryColorLight.withOpacity(0.9),
          900: primaryColorLight.withOpacity(1.0),
        }),
        brightness: Brightness.light, // Define o brilho do tema como claro
      ),
      // Configuração do tema escuro
      darkTheme: ThemeData(
        // Cria um MaterialColor baseado na cor primária do tema escuro
        primarySwatch: MaterialColor(primaryColorDark.value, {
          50: primaryColorDark.withOpacity(0.1),
          100: primaryColorDark.withOpacity(0.2),
          200: primaryColorDark.withOpacity(0.3),
          300: primaryColorDark.withOpacity(0.4),
          400: primaryColorDark.withOpacity(0.5),
          500: primaryColorDark,
          600: primaryColorDark.withOpacity(0.7),
          700: primaryColorDark.withOpacity(0.8),
          800: primaryColorDark.withOpacity(0.9),
          900: primaryColorDark.withOpacity(1.0),
        }),
        brightness: Brightness.dark, // Define o brilho do tema como escuro
        scaffoldBackgroundColor:
            Colors.grey[900], // Cor de fundo do Scaffold no tema escuro
        cardColor: Colors.grey[800], // Cor dos cards no tema escuro
        colorScheme: ColorScheme.dark(
          // Esquema de cores para o tema escuro
          primary: primaryColorDark,
          secondary: primaryColorDark.withOpacity(0.7),
        ),
      ),
      themeMode: _themeMode, // Define o modo de tema atual
      home: HomePage(
          toggleTheme: toggleTheme), // Define a página inicial do aplicativo
    );
  }
}

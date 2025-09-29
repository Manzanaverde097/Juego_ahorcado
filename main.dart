import 'package:flutter/material.dart';
import 'Juego/RegistroPartidas.dart';
import 'Ventanas/Ventana_Inicio.dart';
import 'Ventanas/Ventana_del_Juego.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RegistroPartidas.inicializarDatos();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Juego del Ahorcado',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const Ventana_Inicio(),
        '/juego': (context) => const Ventana_del_Juego(),
      },
    );
  }
}

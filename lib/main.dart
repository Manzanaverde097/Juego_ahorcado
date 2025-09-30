import 'package:flutter/material.dart';
import '../Juego/RegistroPartidas.dart';
import 'Ventanas/Ventana_Inicio.dart';
import 'Ventanas/ventana_del_Juego.dart';

/// Punto de entrada principal de la aplicación
/// Configura el material app, rutas y tema visual
late RegistroPartidas registroPartidas = RegistroPartidas();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registroPartidas.cargar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Configuración principal de la aplicación:
  /// - Rutas de navegación ('/' = Inicio, '/juego' = Juego)
  /// - Tema visual (colores, tipografía)
  /// - Elimina banner de debug en producción

  @override
  Widget build(BuildContextcontext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Juego del Ahorcado',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const Ventana_Inicio(),
        '/juego': (context) => Ventana_del_Juego(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../Juego/RegistroPartidas.dart';
import 'Ventanas/Ventana_Inicio.dart';
import 'Ventanas/ventana_del_Juego.dart';

late RegistroPartidas registroPartidas = RegistroPartidas();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registroPartidas.cargar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContextcontext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Juego del Ahorcado',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const Ventana_Inicio(),
        '/juego': (context) =>  Ventana_del_Juego(),
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ventana_del_Juego extends StatelessWidget {
  const Ventana_del_Juego({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego del Ahorcado'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Aquí va la Lógica del Juego (Palabra y Muñeco)',
              style: TextStyle(fontSize: 18),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver a Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}

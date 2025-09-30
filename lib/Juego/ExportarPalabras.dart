// Gestor de la lista de palabras del juego usando SharedPreferences
/// Se encarga de cargar, almacenar y proporcionar las palabras para el juego
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Exportarpalabras {
  late SharedPreferences _palabras;

  /// Inicializa SharedPreferences y carga palabras si es la primera vez
  Future<void> iniciar() async {
    WidgetsFlutterBinding.ensureInitialized();
    _palabras = await SharedPreferences.getInstance();
    await confirmacion();
  }

  /// Carga la lista predefinida de palabras en almacenamiento local
  Future<void> expalabras() async {
    await _palabras.setStringList('palabras', [
      'perro',
      'gato',
      'casa',
      'arbol',
      'coche',
      'libro',
      'ciudad',
      'mariposa',
      'rio',
      'espejo',
      'agua',
      'fuego',
      'doctor',
    ]);
    await _palabras.setBool('primeravez', false);
  }

  /// Verifica si es la primera vez que se ejecuta la aplicación
  /// Si es la primera vez o no hay datos, carga las palabras iniciales
  Future<void> confirmacion() async {
    bool? aux = _palabras.getBool('primeravez');
    if (aux == null || aux == true) {
      await _palabras.setBool('primeravez', true);
      await expalabras();
      return;
    }
  }

  /// Devuelve la lista completa de palabras almacenadas
  /// Si no hay palabras, retorna una lista vacía como fallback
  List<String> exportarPalabras() {
    List<String> aux = _palabras.getStringList('palabras') ?? [];
    return aux;
  }
}

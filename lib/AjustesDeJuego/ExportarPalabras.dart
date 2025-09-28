/// Esta clase se encargara de exportar, leer y cargar las palabras del juego
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences _palabras;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  _palabras = await SharedPreferences.getInstance();
  await confirmacion();
  }

Future<void> expalabras() async {
  await _palabras.setBool('primeravez', true);
  await _palabras.setStringList('palabras', [
    'perro',
    'gato',
    'casa',
    'árbol',
    'coche',
    'libro',
    'ciudad',
    'mariposa',
    'montaña',
    'río'
  ]);
}

Future<void> confirmacion() async {
  bool? aux = _palabras.getBool('primeravez');
  if (aux == null || aux == true) {
    await _palabras.setString('primeravez', 'true');
    await expalabras();
    return;
  } 
}

  List<String> exportarPalabras(){
  List<String> aux = _palabras.getStringList('palabras') ?? [];
  return aux;
}


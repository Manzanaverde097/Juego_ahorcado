/// Esta clase se encargara de exportar, leer y cargar las palabras del juego
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

  class Exportarpalabras {
    late SharedPreferences _palabras;
  
  Future<void> iniciar() async{
    WidgetsFlutterBinding.ensureInitialized();
    _palabras = await SharedPreferences.getInstance();
    await confirmacion();
    }

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
      'montaña',
      'rio'
    ]);
    await _palabras.setBool('primeravez', false);
  }

  Future<void> confirmacion() async {
    bool? aux = _palabras.getBool('primeravez');
    if (aux == null || aux == true) {
      await _palabras.setBool('primeravez', true);
      await expalabras();
      return;
    } 

  }

    List<String> exportarPalabras(){
    List<String> aux = _palabras.getStringList('palabras') ?? [];
    return aux;
  }
}
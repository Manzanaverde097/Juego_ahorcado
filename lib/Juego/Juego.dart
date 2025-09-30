import 'package:flutter/material.dart';
import '../Juego/ExportarPalabras.dart';
import 'dart:math';

class Juego {

  late List<String> _palabras;
  late int _numero;
  late String _palabra;
  int _intentos = 6;
  late String lineas;
  int letrasAcertadas = 0;

  Future<void> iniciar() async {
    WidgetsFlutterBinding.ensureInitialized();
    Exportarpalabras exportarPalabras = Exportarpalabras();
    await exportarPalabras.iniciar();
    _palabras = await exportarPalabras.exportarPalabras();
  }

  Future iniciarJuego() async {
    // Lógica para iniciar el juego
    randomizarPalabras();
    _palabra = _palabras[_numero];
    lineas = '_ ' * _palabra.length;
    _intentos = 6;
  }

  void randomizarPalabras() {
    // Lógica para randomizar las palabras1
    final random = Random();
    _numero = random.nextInt(_palabras.length);
  }

  bool verificarRespuesta(String respuesta) {
    // Lógica para verificar la respuesta del jugador
    for (int i = 0; i < _palabra.length; i = i + 1) {
      if (_palabra[i] == respuesta) {
        letrasAcertadas = letrasAcertadas + 1;
        return true;
      }
    }

    _intentos = _intentos - 1;
    return false;
  }

  int getIntentos() {
    return _intentos;
  }

  String getPalabra() {
    return _palabra;
  }

  String getLineas() {
    return lineas;
  }

  int getLetrasAcertadas() {
    return letrasAcertadas;
  }
}
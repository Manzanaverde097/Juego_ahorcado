import 'package:flutter/material.dart';
import '../Juego/ExportarPalabras.dart';
import 'dart:math';

/// Núcleo principal de la lógica del juego del ahorcado
/// Maneja: selección de palabras, verificación de letras, estado del juego y progreso
class Juego {
  late List<String> _palabras;
  late int _numero;
  late String _palabra;
  int _intentos = 6;
  late String lineas;
  int letrasAcertadas = 0;

  /// Inicializa el juego cargando las palabras desde ExportarPalabras
  /// Se asegura de que Flutter esté inicializado antes de cargar datos
  Future<void> iniciar() async {
    WidgetsFlutterBinding.ensureInitialized();
    Exportarpalabras exportarPalabras = Exportarpalabras();
    await exportarPalabras.iniciar();
    _palabras = await exportarPalabras.exportarPalabras();
  }

  /// Prepara una nueva partida: selecciona palabra aleatoria y reinicia contadores
  /// Inicializa la representación visual con guiones para cada letra
  Future iniciarJuego() async {
    // Lógica para iniciar el juego
    randomizarPalabras();
    _palabra = _palabras[_numero];
    lineas = '_ ' * _palabra.length;
    _intentos = 6;
  }

  /// Selecciona una palabra aleatoria de la lista disponible
  /// Usa Random para generar un índice aleatorio dentro del rango de palabras
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

  /// @return Número de intentos restantes antes de perder
  int getIntentos() {
    return _intentos;
  }

  /// @return La palabra actual que se está adivinando
  String getPalabra() {
    return _palabra;
  }

  /// @return Representación visual actual de la palabra (con letras adivinadas y guiones)
  String getLineas() {
    return lineas;
  }

  /// @return Número total de letras correctamente adivinadas hasta el momento
  int getLetrasAcertadas() {
    return letrasAcertadas;
  }
}

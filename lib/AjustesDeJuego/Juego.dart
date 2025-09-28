import 'ExportarPalabras.dart';
import 'dart:math';

late List<String> _palabras;
late int _numero;
late String _palabra;
int _intentos = 6;

void main() {
  ExportarPalabras aux = ExportarPalabras();
  _palabras = aux.exportarPalabras();
}

class Juego {

  Future iniciarJuego() async{
    // Lógica para iniciar el juego
    randomizarPalabras();
    _palabra = _palabras[_numero];

  }

  void randomizarPalabras() {
    // Lógica para randomizar las palabras1
    final random = Random();
    _numero = random.nextInt(_palabras.length);
  }

  bool verificarRespuesta(String respuesta) {
    // Lógica para verificar la respuesta del jugador
    for (int i = 0; i < _palabra.length; i=i+1) {
      if (_palabra[i] == respuesta) {
        return true;
      }   
    }
    _intentos= _intentos-1;
        return false;
  }

  int getIntentos() {
    return _intentos;
  }
  
  String getPalabra() {
    return _palabra;
  }
}
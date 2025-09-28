/// Esta clase se encargara de exportar, leer y cargar las palabras del juego
library;
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences _Palabras;
void main() {
  ExportarPalabras aux = ExportarPalabras();
  
  aux.confirmacion();
  }


class ExportarPalabras {
  
  Future<void> expalabras() async {
    _Palabras = await SharedPreferences.getInstance();
    _Palabras.setBool('primeravez', true);
    _Palabras.setStringList('palabras', [
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
    bool? aux = _Palabras.getBool('primeravez');
    if (aux != null || aux == true) {
      return;
    } 
    else {
      _Palabras.setString('primeravez', 'true');
      expalabras();
      return;
    } 
      
  }

  List<String> exportarPalabras(){
    return _Palabras.getStringList('palabras') ?? [];
  }
  
}
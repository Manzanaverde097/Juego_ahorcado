import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _mispreferencias;
late bool aux;

class Usuario {

  Future<void> iniciar() async{
    WidgetsFlutterBinding.ensureInitialized();
    _mispreferencias = await SharedPreferences.getInstance();
     aux = await confirmacion();
  }

Future<bool> confirmacion() async{
    String? nombre = _mispreferencias.getString('nombre');
    if (nombre != "Usuario" && nombre != null) {
      return false;
    } 
    else {
     await _mispreferencias.setString('nombre', 'Usuario');
      return true;
    } 
  }

  Future<String> getNombreUsuario() async {
    WidgetsFlutterBinding.ensureInitialized();
    return _mispreferencias.getString('nombre') ?? 'Jugador';
  }

  Future<void> setNombreUsuario(String nombre) async {
    await _mispreferencias.setString('nombre', nombre);
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _mispreferencias;
late bool aux;

/// Gestor del perfil del usuario y preferencias personalizadas
/// Maneja el nombre del jugador y configuración inicial
class Usuario {
  /// Inicializa las preferencias del usuario
  Future<void> iniciar() async {
    WidgetsFlutterBinding.ensureInitialized();
    _mispreferencias = await SharedPreferences.getInstance();
    aux = await confirmacion();
  }

  /// Verifica si el usuario ya tiene un nombre configurado
  /// Retorna true si es la primera vez (nombre por defecto), false si ya tiene nombre personalizado
  Future<bool> confirmacion() async {
    String? nombre = _mispreferencias.getString('nombre');
    if (nombre != "Usuario" && nombre != null) {
      return false;
    } else {
      await _mispreferencias.setString('nombre', 'Usuario');
      return true;
    }
  }

  /// Obtiene el nombre actual del usuario almacenado
  Future<String> getNombreUsuario() async {
    WidgetsFlutterBinding.ensureInitialized();
    return _mispreferencias.getString('nombre') ?? 'Jugador';
  }

  /// Actualiza el nombre del usuario en almacenamiento persistente
  Future<void> setNombreUsuario(String nombre) async {
    await _mispreferencias.setString('nombre', nombre);
  }
}

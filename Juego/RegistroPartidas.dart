//aqui voy a hacer el registro de partidas del jugasor despues lo explico bien
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart'; 

import 'package:shared_preferences/shared_preferences.dart';
class RegistroPartidas {
  static const String _keyNombre = 'nombreUsuario';
  static const String _keyJugadas = 'PartidasJugadas';
  static const String _keyGanadas = 'PartidasGanadas';
  static const String _keyPerdidas = 'PartidasPerdidas';

  static Future<void> inicializarDatos() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(_keyNombre) == null) {
      await prefs.setString(_keyNombre, 'Jugador'); 
    }
 
    await prefs.setInt(_keyJugadas, prefs.getInt(_keyJugadas) ?? 0);
    await prefs.setInt(_keyGanadas, prefs.getInt(_keyGanadas) ?? 0);
    await prefs.setInt(_keyPerdidas, prefs.getInt(_keyPerdidas) ?? 0);
  }

  static Future<String> getNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyNombre) ?? 'Jugador';
  }
  
  static Future<void> setNombreUsuario(String nombre) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyNombre, nombre);
  }

  static Future<int> getPartidasJugadas() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyJugadas) ?? 0;
  }

  static Future<int> getPartidasGanadas() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyGanadas) ?? 0;
  }

  static Future<int> getPartidasPerdidas() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyPerdidas) ?? 0;
  }
  
  static Future<void> registrarPartida(bool gano) async {
    final prefs = await SharedPreferences.getInstance();
    
    int jugadas = (prefs.getInt(_keyJugadas) ?? 0) + 1;
    await prefs.setInt(_keyJugadas, jugadas);

    if (gano) {
      int ganadas = (prefs.getInt(_keyGanadas) ?? 0) + 1;
      await prefs.setInt(_keyGanadas, ganadas);
    } else {
      int perdidas = (prefs.getInt(_keyPerdidas) ?? 0) + 1;
      await prefs.setInt(_keyPerdidas, perdidas);
    }
  }
}
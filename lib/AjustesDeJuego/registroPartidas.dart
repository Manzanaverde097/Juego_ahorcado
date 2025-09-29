//aqui voy a hacer el registro de partidas del jugasor despues lo explico bien
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart'; 

late SharedPreferences _datos_partidas;

  Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    _datos_partidas = await SharedPreferences.getInstance();
    await confirmacion();
  }

  Future<void> confirmacion() async {
    int? partidasj = _datos_partidas.getInt('PartidasJugadas');
    if (partidasj == null) {
      await _datos_partidas.setInt('PartidasJugadas', 0);
      await _datos_partidas.setInt('PartidasGanadas', 0);
      await _datos_partidas.setInt('PartidasPerdidas', 0);
    }
  }

  int? partidasJugadas() {
    int? aux = _datos_partidas.getInt('PartidasJugadas');
    return aux;
  }

  int? partidasPerdidas() {
    int? aux = _datos_partidas.getInt('PartidasPerdidas');
    return aux;
  }

  int? partidasGanadas() {
    int? aux = _datos_partidas.getInt('PartidasGanadas');
    return aux;
  }

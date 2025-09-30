//aqui voy a hacer el registro de partidas del jugasor despues lo explico bien
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart'; 
  
class RegistroPartidas {

  late SharedPreferences _datos_partidas;

  Future<void> cargar() async{
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

  Future<int> partidasJugadas() async{
    return _datos_partidas.getInt('PartidasJugadas') ?? 0;
  }

  Future<int?> partidasPerdidas() async{
    return _datos_partidas.getInt('PartidasPerdidas') ?? 0;
  }

  Future<int> partidasGanadas() async{
    return _datos_partidas.getInt('PartidasGanadas') ?? 0;
  }

  Future<void> incrementarPartidasJugadas() async{
    int partidasj = await partidasJugadas();
    partidasj = partidasj + 1;
    await _datos_partidas.setInt('PartidasJugadas', partidasj);
  }
  
  Future<void> incrementarPartidasGanadas() async{
    int partidasg = await partidasGanadas();
    partidasg = partidasg + 1;
    await _datos_partidas.setInt('PartidasGanadas', partidasg);
  }

  Future<void> incrementarPartidasPerdidas() async{
    int partidasp = await partidasPerdidas() ?? 0;
    partidasp = partidasp + 1;
    await _datos_partidas.setInt('PartidasPerdidas', partidasp);
  }
}
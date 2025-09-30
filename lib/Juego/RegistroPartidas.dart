import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

/// Gestor completo de estadísticas e historial de partidas del jugador
/// Usa SharedPreferences para persistencia local de datos entre sesiones
/// Maneja: partidas jugadas, ganadas y perdidas
class RegistroPartidas {
  late SharedPreferences _datos_partidas;

  /// Inicializa SharedPreferences y verifica si existen datos previos
  /// Si es la primera vez, inicializa todos los contadores en 0
  Future<void> cargar() async {
    WidgetsFlutterBinding.ensureInitialized();
    _datos_partidas = await SharedPreferences.getInstance();
    await confirmacion();
  }

  /// Verifica si los datos de partidas ya existen en el almacenamiento
  /// Si no existen (primera ejecución), inicializa todos los contadores a 0
  Future<void> confirmacion() async {
    int? partidasj = _datos_partidas.getInt('PartidasJugadas');
    if (partidasj == null) {
      await _datos_partidas.setInt('PartidasJugadas', 0);
      await _datos_partidas.setInt('PartidasGanadas', 0);
      await _datos_partidas.setInt('PartidasPerdidas', 0);
    }
  }

  /// @return Número total de partidas jugadas por el usuario
  Future<int> partidasJugadas() async {
    return _datos_partidas.getInt('PartidasJugadas') ?? 0;
  }

  /// @return Número total de partidas perdidas por el usuario
  Future<int?> partidasPerdidas() async {
    return _datos_partidas.getInt('PartidasPerdidas') ?? 0;
  }

  /// @return Número total de partidas ganadas por el usuario
  Future<int> partidasGanadas() async {
    return _datos_partidas.getInt('PartidasGanadas') ?? 0;
  }

  /// Incrementa en 1 el contador de partidas jugadas
  /// Se llama automáticamente al finalizar cada partida (ganada o perdida)
  Future<void> incrementarPartidasJugadas() async {
    int partidasj = await partidasJugadas();
    partidasj = partidasj + 1;
    await _datos_partidas.setInt('PartidasJugadas', partidasj);
  }

  /// Incrementa en 1 el contador de partidas ganadas
  /// Se llama cuando el jugador adivina la palabra correctamente
  Future<void> incrementarPartidasGanadas() async {
    int partidasg = await partidasGanadas();
    partidasg = partidasg + 1;
    await _datos_partidas.setInt('PartidasGanadas', partidasg);
  }

  /// Incrementa en 1 el contador de partidas perdidas
  /// Se llama cuando el jugador se queda sin intentos
  Future<void> incrementarPartidasPerdidas() async {
    int partidasp = await partidasPerdidas() ?? 0;
    partidasp = partidasp + 1;
    await _datos_partidas.setInt('PartidasPerdidas', partidasp);
  }
}

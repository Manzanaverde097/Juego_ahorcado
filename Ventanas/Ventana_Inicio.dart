import 'package:flutter/material.dart';
import '../Juego/RegistroPartidas.dart';
import '../Juego/widgets/Estadisticas.dart';

class Ventana_Inicio extends StatefulWidget {
  const Ventana_Inicio({super.key});

  @override
  State<Ventana_Inicio> createState() => _Ventana_InicioState();
}

class _Ventana_InicioState extends State<Ventana_Inicio> {
  final TextEditingController _myController = TextEditingController();
  String _nombreActual = 'Cargando...';
  bool _mostrarCampoNombre = false;

  @override
  void initState() {
    super.initState();
    _cargarNombre();
  }

  Future<void> _cargarNombre() async {
    final nombre = await RegistroPartidas.getNombreUsuario();
    setState(() {
      _nombreActual = nombre;
      // Muestra el campo si el nombre es el default
      _mostrarCampoNombre = (nombre == 'Jugador' || nombre == 'Usuario');
    });
  }

  void _mostrarDialogoEstadisticas(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Perfil y Estadísticas'),
          content: FutureBuilder<String>(
            future: RegistroPartidas.getNombreUsuario(),
            builder: (context, snapshotNombre) {
              final String nombre = snapshotNombre.data ?? 'Jugador';

              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Perfil: $nombre',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    FutureBuilder<int>(
                      future: RegistroPartidas.getPartidasJugadas(),
                      builder: (context, snapshotJugadas) {
                        return Text(
                          'Partidas Jugadas: ${snapshotJugadas.data ?? 0}',
                          style: TextStyle(color: Colors.blue.shade700),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    const Estadisticas(),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _guardarNombre() async {
    final nombre = _myController.text.trim();
    if (nombre.isNotEmpty) {
      await RegistroPartidas.setNombreUsuario(nombre);
      _myController.clear();
      setState(() {
        _nombreActual = nombre;
        _mostrarCampoNombre = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ahorcado'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.leaderboard),
            tooltip: 'Perfil y Estadísticas',
            onPressed: () => _mostrarDialogoEstadisticas(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Bienvenido al ahorcado'),
            const SizedBox(height: 20),

            Visibility(
              visible: _mostrarCampoNombre,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _myController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Introduce tu nombre',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _guardarNombre,
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ),
            ),

            if (!_mostrarCampoNombre)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Jugando como: $_nombreActual',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ElevatedButton(
              onPressed: () {
                // Navega a la pantalla del juego (la que tú debes construir)
                Navigator.pushNamed(context, '/juego');
              },
              child: const Text('Empezar a jugar'),
            ),
          ],
        ),
      ),
    );
  }
}

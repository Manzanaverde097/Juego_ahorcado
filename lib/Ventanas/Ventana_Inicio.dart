import 'package:flutter/material.dart';
import 'package:juego_ahorcado/Juego/RegistroPartidas.dart';
import '../widgets/estadisticas.dart';
import '../Juego/Usuario.dart';

class Ventana_Inicio extends StatefulWidget {

  const Ventana_Inicio({super.key});

  @override
  State<Ventana_Inicio> createState() => Ventana_InicioState();
}

class Ventana_InicioState extends State<Ventana_Inicio> {
  Ventana_InicioState();
  final TextEditingController _myController = TextEditingController();
  String _nombreActual = 'Cargando...';
  bool _mostrarCampoNombre = false;
  late RegistroPartidas registroPartidas = RegistroPartidas();
  
  late bool aux;
  late Usuario usuario = Usuario();

  @override
  void initState() {
    super.initState();
    _cargarNombre();
  }

  Future<void> _cargarNombre() async {
    await usuario.iniciar();
    final nombre = await usuario.getNombreUsuario();
    setState(() {
      _nombreActual = nombre;
      // Muestra el campo si el nombre es el default
      _mostrarCampoNombre = (nombre == 'Jugador' || nombre == 'Usuario');
    });
  }

  Future<void> _mostrarDialogoEstadisticas(BuildContext context) async {
    await registroPartidas.cargar();
    final Partidas = registroPartidas;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Perfil y Estadísticas'),
          content: FutureBuilder<String>(
            future: usuario.getNombreUsuario(),
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
                      future: registroPartidas.partidasJugadas(),
                      builder: (context, snapshotJugadas) {
                        return Text(
                          'Partidas Jugadas: ${snapshotJugadas.data ?? 0}',
                          style: TextStyle(color: Colors.blue.shade700),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Estadisticas(Partidas: Partidas),
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
      await usuario.setNombreUsuario(nombre);
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
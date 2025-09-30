import 'package:flutter/material.dart';
import 'package:juego_ahorcado/Juego/RegistroPartidas.dart';
import 'package:juego_ahorcado/Juego/Juego.dart';

class Ventana_del_Juego extends StatefulWidget {
  final Juego juego = Juego();
  Ventana_del_Juego({super.key});

  @override
  State<Ventana_del_Juego> createState() => _Ventana_del_JuegoState();
}

class _Ventana_del_JuegoState extends State<Ventana_del_Juego> {

  late RegistroPartidas registroPartidas;
  String aux = "";
  String intentos = "Intentos: ";
  bool juegoContinua = true;

  @override
  void initState(){inicializarJuego();
    super.initState();
    
  }

  Future<void> cargarRegistro(bool juego) async {
    if (juego) {
      await registroPartidas.incrementarPartidasGanadas();
    } else {
      await registroPartidas.incrementarPartidasPerdidas();
    }
    await registroPartidas.incrementarPartidasJugadas();
  }

  Future<void> inicializarJuego() async {
    await widget.juego.iniciar();
    await widget.juego.iniciarJuego();
    registroPartidas = RegistroPartidas();
    await registroPartidas.cargar();
    setState(() {

      aux = widget.juego.getLineas();
      intentos = "Intentos: "+ widget.juego.getIntentos().toString();

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego del Ahorcado'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              aux,
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Ingresa una letra',
                contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                border: OutlineInputBorder(),
              ),
              maxLength: 1,
              textAlign: TextAlign.center,
              enabled: juegoContinua,
              onSubmitted: (value) {
                bool resultado = widget.juego.verificarRespuesta(value);
                setState(() {
                  if (resultado) {
                    String lineas = "";
                    for (int i = 0; i < widget.juego.getPalabra().length; i++) {
                      if (widget.juego.getPalabra()[i] == value) {
                        lineas += value + " ";
                      } else {
                        lineas += aux[i * 2] + " ";
                      }
                    }
                    aux = lineas;
                  }
                  else {
                    intentos = "Intentos: " + widget.juego.getIntentos().toString();
                    if (widget.juego.getIntentos() == 0) {
                      intentos = "¡Has perdido! La palabra era: " + widget.juego.getPalabra();
                      aux = widget.juego.getPalabra();
                      cargarRegistro(false);
                      setState(() {
                        juegoContinua = false;
                      });
                    }
                  }
                  if (widget.juego.getLetrasAcertadas() == widget.juego.getPalabra().length) {
                    intentos = "¡Has ganado! ";
                    juegoContinua = false;
                    cargarRegistro(true);
                    setState(() {
                      juegoContinua = false;
                    });
                  }
                });
              },
            ),
            Text(intentos),
            ElevatedButton(
              onPressed: () {
                inicializarJuego();
                setState(() {
                  juegoContinua = true;
                });
              }, 
              child: 
              const Text('Reiniciar Juego'),
            ),
          ],
        ),
      ),
    );
  }
}
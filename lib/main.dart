import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _myController = TextEditingController();
late SharedPreferences _mispreferencias;
late bool aux;

Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    _mispreferencias = await SharedPreferences.getInstance();
     aux = await confirmacion();
    runApp(const MyApp());
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
      home: const MyHomePage(title: 'Ahorcado'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'Configuración',
                  onPressed: () {
                    //AQUI VA BARRA QUE SEA PARA EL PERFIL, Y LAS PARTIDAS JUGADAS
                  },
      ),
            ]
      ), 
            body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Bienvenido al ahoracado'),
            const SizedBox(height: 20),
            Visibility(
                visible: aux,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children:[
                TextField(
                  controller: _myController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Introduce tu nombre',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String nombre = _myController.text;
                      if (nombre.isNotEmpty) {
                        _mispreferencias.setString('nombre', nombre);
                        aux = false;
                        setState(() {});
                    }
                  }, child: const Text('Guardar'),
                  ),
                ],
                ),
              ),
            Text(
              _mispreferencias.getString('nombre')!,
            ),
            ElevatedButton(
              onPressed: () {

                ;
              },
              child: const Text('Empezar a jugar'),
              )
          ],
        ),
      ),
    );
  }
}
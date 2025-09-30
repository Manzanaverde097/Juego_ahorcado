import 'package:flutter/material.dart';
import '../Juego/RegistroPartidas.dart';

class Estadisticas extends StatelessWidget {

  final RegistroPartidas Partidas;

  const Estadisticas({
    super.key,
    required this.Partidas,});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
    
        this.Partidas.partidasGanadas(),
        this.Partidas.partidasPerdidas(),
      ]),
      builder: (context, AsyncSnapshot<List<int?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Text('Error al cargar estadísticas.');
        }

        final int? victorias = snapshot.data![0];
        final int? perdidas = snapshot.data![1];

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildStatBox(context, 'VICTORIAS', victorias!, Colors.green),

            const SizedBox(width: 20),

            _buildStatBox(context, 'DERROTAS', perdidas!, Colors.red),
          ],
        );
      },
    );
  }

  Widget _buildStatBox(
    BuildContext context,
    String title,
    int count,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$count',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: color),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

/// Widget personalizado que dibuja el muñeco del ahorcado progresivamente
/// Muestra diferentes partes del muñeco según la cantidad de errores
class MunecoAhorcado extends StatelessWidget {
  final int intentosRestantes;
  final int maxIntentos;

  const MunecoAhorcado({
    super.key,
    required this.intentosRestantes,
    this.maxIntentos = 6,
  });

  @override
  Widget build(BuildContext context) {
    final errores = maxIntentos - intentosRestantes;

    return Container(
      height: 200,
      width: 150,
      child: CustomPaint(painter: _AhorcadoPainter(errores: errores)),
    );
  }
}

/// Clase que maneja el dibujo real del ahorcado usando CustomPainter
class _AhorcadoPainter extends CustomPainter {
  final int errores;

  _AhorcadoPainter({required this.errores});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Base y estructura del ahorcado (siempre visible)
    _dibujarEstructura(canvas, size, paint);

    // Dibujar segun los errrores
    if (errores > 0) _dibujarCabeza(canvas, size, paint);
    if (errores > 1) _dibujarCuerpo(canvas, size, paint);
    if (errores > 2) _dibujarBrazoIzquierdo(canvas, size, paint);
    if (errores > 3) _dibujarBrazoDerecho(canvas, size, paint);
    if (errores > 4) _dibujarPiernaIzquierda(canvas, size, paint);
    if (errores > 5) _dibujarPiernaDerecha(canvas, size, paint);
  }

  /// Dibuja la estructura base del ahorcado (postes y soga)
  void _dibujarEstructura(Canvas canvas, Size size, Paint paint) {
    // Base
    canvas.drawLine(
      Offset(0, size.height - 20),
      Offset(size.width * 0.7, size.height - 20),
      paint,
    );
    //el poste
    canvas.drawLine(
      Offset(size.width * 0.2, size.height - 20),
      Offset(size.width * 0.2, 20),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.2, 20),
      Offset(size.width * 0.6, 20),
      paint,
    );

    // la sofa
    canvas.drawLine(
      Offset(size.width * 0.6, 20),
      Offset(size.width * 0.6, 40),
      paint,
    );
  }

  void _dibujarCabeza(Canvas canvas, Size size, Paint paint) {
    canvas.drawCircle(Offset(size.width * 0.6, 60), 20, paint);
  }

  void _dibujarCuerpo(Canvas canvas, Size size, Paint paint) {
    canvas.drawLine(
      Offset(size.width * 0.6, 80),
      Offset(size.width * 0.6, 140),
      paint,
    );
  }

  void _dibujarBrazoIzquierdo(Canvas canvas, Size size, Paint paint) {
    canvas.drawLine(
      Offset(size.width * 0.6, 100),
      Offset(size.width * 0.4, 120),
      paint,
    );
  }

  void _dibujarBrazoDerecho(Canvas canvas, Size size, Paint paint) {
    canvas.drawLine(
      Offset(size.width * 0.6, 100),
      Offset(size.width * 0.8, 120),
      paint,
    );
  }

  void _dibujarPiernaIzquierda(Canvas canvas, Size size, Paint paint) {
    canvas.drawLine(
      Offset(size.width * 0.6, 140),
      Offset(size.width * 0.4, 170),
      paint,
    );
  }

  void _dibujarPiernaDerecha(Canvas canvas, Size size, Paint paint) {
    canvas.drawLine(
      Offset(size.width * 0.6, 140),
      Offset(size.width * 0.8, 170),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

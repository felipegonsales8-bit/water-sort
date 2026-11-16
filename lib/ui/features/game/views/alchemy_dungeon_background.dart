import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Illustrated fantasy locations behind the potion puzzle.
class AlchemyDungeonBackground extends CustomPainter {
  const AlchemyDungeonBackground({required this.level});
  final int level;

  @override
  void paint(Canvas canvas, Size size) {
    final scene = ((level - 1) ~/ 10) % 3;
    final bounds = Offset.zero & size;
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF241B2B), Color(0xFF15111C), Color(0xFF090A10)],
      ).createShader(bounds);
    canvas.drawRect(bounds, bg);
    _drawStonework(canvas, size);
    if (scene == 0) {
      _drawDungeonArch(canvas, size);
    } else if (scene == 1) {
      _drawCastleWindows(canvas, size);
    } else {
      _drawLibraryShelves(canvas, size);
    }
    _drawTorches(canvas, size);
    _drawFloor(canvas, size);
  }

  void _drawStonework(Canvas canvas, Size size) {
    final rows = 12;
    final blockH = size.height / rows;
    final fill = Paint()..color = const Color(0xFF8B735D).withValues(alpha: 0.035);
    final stroke = Paint()
      ..color = const Color(0xFFB89A70).withValues(alpha: 0.055)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var row = 0; row < rows; row++) {
      final shift = row.isEven ? 0.0 : size.width * 0.11;
      for (var col = -1; col < 5; col++) {
        final x = col * size.width / 4 + shift;
        final r = Rect.fromLTWH(x, row * blockH, size.width / 4 - 5, blockH - 5);
        final rounded = RRect.fromRectAndRadius(r, const Radius.circular(5));
        canvas.drawRRect(rounded, fill);
        canvas.drawRRect(rounded, stroke);
      }
    }
  }

  void _drawDungeonArch(Canvas canvas, Size size) {
    final arch = Paint()
      ..color = const Color(0xFFC69A4A).withValues(alpha: 0.13)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final outer = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.43),
      width: size.width * 0.86,
      height: size.height * 0.78,
    );
    canvas.drawArc(outer, math.pi, math.pi, false, arch);
    arch.strokeWidth = 1.5;
    canvas.drawArc(outer.deflate(18), math.pi, math.pi, false, arch);
    final pillar = Paint()
      ..color = const Color(0xFFB89A70).withValues(alpha: 0.08)
      ..strokeWidth = 7;
    canvas.drawLine(Offset(size.width * 0.08, size.height * 0.12),
        Offset(size.width * 0.08, size.height * 0.84), pillar);
    canvas.drawLine(Offset(size.width * 0.92, size.height * 0.12),
        Offset(size.width * 0.92, size.height * 0.84), pillar);
  }

  void _drawCastleWindows(Canvas canvas, Size size) {
    final glow = Paint()..color = const Color(0xFFD5B77A).withValues(alpha: 0.08);
    final outline = Paint()
      ..color = const Color(0xFFC69A4A).withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (final x in [size.width * 0.18, size.width * 0.82]) {
      final r = Rect.fromCenter(
        center: Offset(x, size.height * 0.25),
        width: size.width * 0.17,
        height: size.height * 0.29,
      );
      final path = Path()
        ..moveTo(r.left, r.bottom)
        ..lineTo(r.left, r.top + r.width / 2)
        ..quadraticBezierTo(r.center.dx, r.top - r.width / 2, r.right, r.top + r.width / 2)
        ..lineTo(r.right, r.bottom)
        ..close();
      canvas.drawPath(path, glow);
      canvas.drawPath(path, outline);
      canvas.drawLine(Offset(x, r.top), Offset(x, r.bottom), outline);
      canvas.drawLine(Offset(r.left, r.center.dy), Offset(r.right, r.center.dy), outline);
    }
  }

  void _drawLibraryShelves(Canvas canvas, Size size) {
    final wood = Paint()
      ..color = const Color(0xFFB8874B).withValues(alpha: 0.11)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final glass = Paint()..color = const Color(0xFF8B6AA8).withValues(alpha: 0.16);
    for (final side in [0.04, 0.76]) {
      for (var row = 0; row < 3; row++) {
        final y = size.height * (0.22 + row * 0.19);
        canvas.drawLine(Offset(size.width * side, y),
            Offset(size.width * (side + 0.2), y), wood);
        for (var i = 0; i < 4; i++) {
          final x = size.width * (side + 0.025 + i * 0.045);
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x, y - 25 - (i % 2) * 7, 12, 25 + (i % 2) * 7),
              const Radius.circular(5),
            ),
            glass,
          );
        }
      }
    }
  }

  void _drawTorches(Canvas canvas, Size size) {
    for (final x in [size.width * 0.11, size.width * 0.89]) {
      final center = Offset(x, size.height * 0.34);
      final glow = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFFB85C).withValues(alpha: 0.18),
            const Color(0xFFFF8A35).withValues(alpha: 0.045),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: center, radius: 70));
      canvas.drawCircle(center, 70, glow);
      final flame = Paint()..color = const Color(0xFFFFB85C).withValues(alpha: 0.34);
      final path = Path()
        ..moveTo(x, center.dy - 13)
        ..quadraticBezierTo(x + 12, center.dy + 1, x, center.dy + 9)
        ..quadraticBezierTo(x - 10, center.dy + 1, x, center.dy - 13)
        ..close();
      canvas.drawPath(path, flame);
    }
  }

  void _drawFloor(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, size.height * 0.84, size.width, size.height * 0.16);
    final floor = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFB89A70).withValues(alpha: 0.015),
          const Color(0xFF050509).withValues(alpha: 0.35),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, floor);
    final line = Paint()
      ..color = const Color(0xFFC69A4A).withValues(alpha: 0.08)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, size.height * 0.84),
        Offset(size.width, size.height * 0.84), line);
  }

  @override
  bool shouldRepaint(covariant AlchemyDungeonBackground oldDelegate) =>
      oldDelegate.level != level;
}

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Atmospheric fantasy environments shown behind the potion puzzle.
/// The artwork stays around the edges so the tubes remain easy to read.
class AlchemyDungeonBackground extends CustomPainter {
  const AlchemyDungeonBackground({required this.level});

  final int level;

  @override
  void paint(Canvas canvas, Size size) {
    final scene = ((level - 1) ~/ 10) % 3;
    final bounds = Offset.zero & size;

    final background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF302039),
          Color(0xFF1B1424),
          Color(0xFF100D18),
          Color(0xFF08090F),
        ],
        stops: [0, 0.38, 0.78, 1],
      ).createShader(bounds);
    canvas.drawRect(bounds, background);

    _drawAmbientGlow(canvas, size, scene);
    _drawStoneWalls(canvas, size);
    if (scene == 0) {
      _drawDungeonHall(canvas, size);
    } else if (scene == 1) {
      _drawCastleHall(canvas, size);
    } else {
      _drawAlchemyLibrary(canvas, size);
    }
    _drawWallDetails(canvas, size, scene);
    _drawTorches(canvas, size);
    _drawFloor(canvas, size);
    _drawVignette(canvas, size);
  }

  void _drawAmbientGlow(Canvas canvas, Size size, int scene) {
    final color = scene == 1
        ? const Color(0xFFB78B48)
        : scene == 2
            ? const Color(0xFF7650A5)
            : const Color(0xFFB45B39);
    final center = Offset(size.width / 2, size.height * 0.38);
    final glow = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: 0.16),
          color.withValues(alpha: 0.055),
          Colors.transparent,
        ],
        stops: const [0, 0.48, 1],
      ).createShader(Rect.fromCircle(center: center, radius: size.width * 0.8));
    canvas.drawCircle(center, size.width * 0.8, glow);
  }

  void _drawStoneWalls(Canvas canvas, Size size) {
    final blockHeight = size.height / 13;
    final blockWidth = size.width / 4;
    final fill = Paint();
    final outline = Paint()
      ..color = const Color(0xFFC5A47B).withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    for (var row = 0; row < 13; row++) {
      final shift = row.isEven ? 0.0 : blockWidth * 0.5;
      for (var col = -1; col < 6; col++) {
        final x = col * blockWidth + shift;
        final rect = Rect.fromLTWH(
          x + 2,
          row * blockHeight + 2,
          blockWidth - 5,
          blockHeight - 5,
        );
        final shade = ((row * 7 + col * 11).abs() % 3) * 0.025;
        fill.color = const Color(0xFF9A806B).withValues(alpha: 0.075 + shade);
        final stone = RRect.fromRectAndRadius(
          rect,
          const Radius.circular(4),
        );
        canvas.drawRRect(stone, fill);
        canvas.drawRRect(stone, outline);
        final highlight = Paint()
          ..color = const Color(0xFFE4C79D).withValues(alpha: 0.055)
          ..strokeWidth = 1;
        canvas.drawLine(
          Offset(rect.left + 7, rect.top + 3),
          Offset(rect.right - 9, rect.top + 3),
          highlight,
        );
      }
    }
  }

  void _drawDungeonHall(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.40);
    final outer = Rect.fromCenter(
      center: center,
      width: size.width * 0.94,
      height: size.height * 0.86,
    );
    final archFill = Paint()
      ..color = const Color(0xFF05050A).withValues(alpha: 0.19);
    final archStroke = Paint()
      ..color = const Color(0xFFC49A63).withValues(alpha: 0.30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final innerStroke = Paint()
      ..color = const Color(0xFFE0BD83).withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final archPath = Path()
      ..moveTo(outer.left, outer.bottom)
      ..lineTo(outer.left, outer.top + outer.width * 0.48)
      ..quadraticBezierTo(
        center.dx,
        outer.top - outer.width * 0.08,
        outer.right,
        outer.top + outer.width * 0.48,
      )
      ..lineTo(outer.right, outer.bottom);
    canvas.drawPath(archPath, archFill);
    canvas.drawPath(archPath, archStroke);
    canvas.drawPath(
      archPath.shift(const Offset(0, 13)),
      innerStroke,
    );

    final pillarPaint = Paint()
      ..color = const Color(0xFFB69A7A).withValues(alpha: 0.18)
      ..strokeWidth = 11
      ..strokeCap = StrokeCap.square;
    for (final x in [size.width * 0.075, size.width * 0.925]) {
      canvas.drawLine(
        Offset(x, size.height * 0.20),
        Offset(x, size.height * 0.82),
        pillarPaint,
      );
      final capital = Paint()
        ..color = const Color(0xFFD3B184).withValues(alpha: 0.25)
        ..strokeWidth = 17;
      canvas.drawLine(
        Offset(x - 9, size.height * 0.23),
        Offset(x + 9, size.height * 0.23),
        capital,
      );
      canvas.drawLine(
        Offset(x - 9, size.height * 0.78),
        Offset(x + 9, size.height * 0.78),
        capital,
      );
    }
  }

  void _drawCastleHall(Canvas canvas, Size size) {
    final stone = Paint()
      ..color = const Color(0xFFB99A70).withValues(alpha: 0.16);
    final gold = Paint()
      ..color = const Color(0xFFE2BD78).withValues(alpha: 0.34)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;

    for (final x in [size.width * 0.17, size.width * 0.83]) {
      final window = Rect.fromCenter(
        center: Offset(x, size.height * 0.29),
        width: size.width * 0.19,
        height: size.height * 0.32,
      );
      final path = Path()
        ..moveTo(window.left, window.bottom)
        ..lineTo(window.left, window.top + window.width * 0.48)
        ..quadraticBezierTo(
          x,
          window.top - window.width * 0.48,
          window.right,
          window.top + window.width * 0.48,
        )
        ..lineTo(window.right, window.bottom)
        ..close();
      canvas.drawPath(path, stone);
      canvas.drawPath(path, gold);
      canvas.drawLine(Offset(x, window.top), Offset(x, window.bottom), gold);
      canvas.drawLine(
        Offset(window.left, window.center.dy),
        Offset(window.right, window.center.dy),
        gold,
      );
      final sill = Paint()
        ..color = const Color(0xFFD6B47A).withValues(alpha: 0.22)
        ..strokeWidth = 6;
      canvas.drawLine(
        Offset(window.left - 7, window.bottom),
        Offset(window.right + 7, window.bottom),
        sill,
      );
    }

    // Distant battlements and narrow castle banners.
    final battlement = Paint()
      ..color = const Color(0xFFB99A70).withValues(alpha: 0.16);
    final y = size.height * 0.09;
    canvas.drawRect(Rect.fromLTWH(0, y, size.width, 9), battlement);
    for (var i = 0; i < 9; i++) {
      canvas.drawRect(
        Rect.fromLTWH(i * size.width / 8, y - 9, size.width / 16, 11),
        battlement,
      );
    }
    _drawBanner(canvas, Offset(size.width * 0.08, size.height * 0.37));
    _drawBanner(canvas, Offset(size.width * 0.92, size.height * 0.37));
  }

  void _drawBanner(Canvas canvas, Offset anchor) {
    final pole = Paint()
      ..color = const Color(0xFFD4B27B).withValues(alpha: 0.35)
      ..strokeWidth = 2;
    canvas.drawLine(anchor, anchor + const Offset(0, 72), pole);
    final banner = Path()
      ..moveTo(anchor.dx + 2, anchor.dy + 5)
      ..lineTo(anchor.dx + 25, anchor.dy + 12)
      ..lineTo(anchor.dx + 22, anchor.dy + 58)
      ..lineTo(anchor.dx + 12, anchor.dy + 48)
      ..lineTo(anchor.dx + 2, anchor.dy + 58)
      ..close();
    canvas.drawPath(
      banner,
      Paint()..color = const Color(0xFF74344D).withValues(alpha: 0.42),
    );
    canvas.drawPath(
      banner,
      Paint()
        ..color = const Color(0xFFD8B16D).withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawAlchemyLibrary(Canvas canvas, Size size) {
    final wood = Paint()
      ..color = const Color(0xFFB8874B).withValues(alpha: 0.25)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final bookPaint = Paint();
    final colors = [
      const Color(0xFF8D527F),
      const Color(0xFF527B9B),
      const Color(0xFF9A713D),
      const Color(0xFF5D8067),
    ];

    for (final side in [0.025, 0.765]) {
      for (var row = 0; row < 4; row++) {
        final y = size.height * (0.20 + row * 0.16);
        final left = size.width * side;
        final right = left + size.width * 0.21;
        canvas.drawLine(Offset(left, y), Offset(right, y), wood);
        for (var i = 0; i < 5; i++) {
          final bookWidth = size.width * 0.027;
          final x = left + size.width * (0.012 + i * 0.039);
          final height = size.height * (0.065 + (i % 3) * 0.012);
          bookPaint.color = colors[(i + row) % colors.length]
              .withValues(alpha: 0.36);
          final book = RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y - height, bookWidth, height),
            const Radius.circular(2),
          );
          canvas.drawRRect(book, bookPaint);
          canvas.drawLine(
            Offset(x + bookWidth * 0.25, y - height + 5),
            Offset(x + bookWidth * 0.25, y - 4),
            Paint()
              ..color = const Color(0xFFF0D6A2).withValues(alpha: 0.24)
              ..strokeWidth = 1,
          );
        }
      }
    }

    // Alchemical symbols on the side panels.
    final runePaint = Paint()
      ..color = const Color(0xFFC49A63).withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (final x in [size.width * 0.12, size.width * 0.88]) {
      final center = Offset(x, size.height * 0.73);
      canvas.drawCircle(center, 19, runePaint);
      canvas.drawLine(
        Offset(x, center.dy - 14),
        Offset(x, center.dy + 14),
        runePaint,
      );
      canvas.drawLine(
        Offset(x - 12, center.dy + 7),
        Offset(x + 12, center.dy - 7),
        runePaint,
      );
    }
  }

  void _drawWallDetails(Canvas canvas, Size size, int scene) {
    final trim = Paint()
      ..color = const Color(0xFFC69A4A).withValues(alpha: 0.18)
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(0, size.height * 0.16),
      Offset(size.width, size.height * 0.16),
      trim,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.81),
      Offset(size.width, size.height * 0.81),
      trim,
    );

    final medallionPaint = Paint()
      ..color = (scene == 2 ? const Color(0xFFB18AE0) : const Color(0xFFD4AD70))
          .withValues(alpha: 0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final center = Offset(size.width * 0.5, size.height * 0.13);
    canvas.drawCircle(center, 17, medallionPaint);
    canvas.drawCircle(center, 10, medallionPaint);
    canvas.drawLine(
      Offset(center.dx, center.dy - 23),
      Offset(center.dx, center.dy + 23),
      medallionPaint,
    );
  }

  void _drawTorches(Canvas canvas, Size size) {
    for (final x in [size.width * 0.105, size.width * 0.895]) {
      final center = Offset(x, size.height * 0.39);
      final radius = size.width * 0.16;
      final glow = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFFC36B).withValues(alpha: 0.32),
            const Color(0xFFFF8A35).withValues(alpha: 0.12),
            Colors.transparent,
          ],
          stops: const [0, 0.38, 1],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, glow);

      final bracket = Paint()
        ..color = const Color(0xFF9B704A).withValues(alpha: 0.55)
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        Offset(x, center.dy + 17),
        Offset(x, center.dy + 32),
        bracket,
      );
      canvas.drawLine(
        Offset(x - 8, center.dy + 32),
        Offset(x + 8, center.dy + 32),
        bracket,
      );

      final flame = Path()
        ..moveTo(x, center.dy - 22)
        ..cubicTo(x + 18, center.dy - 4, x + 9, center.dy + 11, x, center.dy + 13)
        ..cubicTo(x - 13, center.dy + 7, x - 13, center.dy - 5, x, center.dy - 22)
        ..close();
      canvas.drawPath(
        flame,
        Paint()..color = const Color(0xFFFFB34F).withValues(alpha: 0.82),
      );
      canvas.drawCircle(
        Offset(x, center.dy + 1),
        4,
        Paint()..color = const Color(0xFFFFE3A1).withValues(alpha: 0.78),
      );
    }
  }

  void _drawFloor(Canvas canvas, Size size) {
    final top = size.height * 0.81;
    final floorRect = Rect.fromLTWH(0, top, size.width, size.height - top);
    final floor = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF9C7955).withValues(alpha: 0.12),
          const Color(0xFF07070C).withValues(alpha: 0.72),
        ],
      ).createShader(floorRect);
    canvas.drawRect(floorRect, floor);

    final seam = Paint()
      ..color = const Color(0xFFC69A63).withValues(alpha: 0.14)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, top), Offset(size.width, top), seam);
    for (var i = -2; i <= 4; i++) {
      final x = size.width * i / 2;
      canvas.drawLine(
        Offset(size.width / 2, top),
        Offset(x, size.height),
        seam,
      );
    }
    for (var row = 1; row <= 3; row++) {
      final y = top + (size.height - top) * row / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), seam);
    }
  }

  void _drawVignette(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final vignette = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.05),
        radius: 0.92,
        colors: [
          Colors.transparent,
          Colors.black.withValues(alpha: 0.10),
          Colors.black.withValues(alpha: 0.43),
        ],
        stops: const [0.42, 0.72, 1],
      ).createShader(rect);
    canvas.drawRect(rect, vignette);
  }

  @override
  bool shouldRepaint(covariant AlchemyDungeonBackground oldDelegate) =>
      oldDelegate.level != level;
}

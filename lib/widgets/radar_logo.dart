// lib/widgets/radar_logo.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Animated radar sweep used as the brand mark.
class RadarLogo extends StatefulWidget {
  final double size;
  const RadarLogo({super.key, this.size = 96});

  @override
  State<RadarLogo> createState() => _RadarLogoState();
}

class _RadarLogoState extends State<RadarLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final grid = Theme.of(context).colorScheme.outline;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CustomPaint(
        size: Size.square(widget.size),
        painter: _RadarPainter(
          angle: _controller.value * 2 * math.pi,
          grid: grid,
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final double angle;
  final Color grid;
  _RadarPainter({required this.angle, required this.grid});

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2;
    final rect = Rect.fromCircle(center: c, radius: r);

    // Background disc
    canvas.drawCircle(c, r, Paint()..color = AppColors.radar.withOpacity(0.05));

    // Grid rings + crosshair
    final gridPaint = Paint()
      ..color = grid
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (final f in [1.0, 0.66, 0.33]) {
      canvas.drawCircle(c, r * f, gridPaint);
    }
    canvas.drawLine(Offset(c.dx - r, c.dy), Offset(c.dx + r, c.dy), gridPaint);
    canvas.drawLine(Offset(c.dx, c.dy - r), Offset(c.dx, c.dy + r), gridPaint);

    // Sweep
    final sweep = Paint()
      ..shader = SweepGradient(
        colors: [
          Colors.transparent,
          AppColors.radar.withOpacity(0.0),
          AppColors.radar.withOpacity(0.55),
        ],
        stops: const [0.0, 0.7, 1.0],
        transform: GradientRotation(angle),
      ).createShader(rect);
    canvas.drawCircle(c, r, sweep);

    // Leading edge
    final edge = Offset(c.dx + r * math.cos(angle), c.dy + r * math.sin(angle));
    canvas.drawLine(
      c,
      edge,
      Paint()
        ..color = AppColors.radar
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );

    // Blips: teal = matched, amber = gap
    canvas.drawCircle(
      c + Offset(r * 0.45, -r * 0.35),
      r * 0.07,
      Paint()..color = AppColors.radar,
    );
    canvas.drawCircle(
      c + Offset(-r * 0.5, r * 0.25),
      r * 0.07,
      Paint()..color = AppColors.amber,
    );
    canvas.drawCircle(
      c + Offset(r * 0.15, r * 0.6),
      r * 0.06,
      Paint()..color = AppColors.amber,
    );

    // Center dot
    canvas.drawCircle(c, r * 0.06, Paint()..color = AppColors.radar);
  }

  @override
  bool shouldRepaint(covariant _RadarPainter old) =>
      old.angle != angle || old.grid != grid;
}

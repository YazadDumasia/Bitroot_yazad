import 'package:flutter/material.dart';

class SliderRectangularThumbShape extends SliderComponentShape {
  BuildContext buildContext;

  SliderRectangularThumbShape(this.buildContext);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(30.0, 20.0); // Customize the size of the thumb
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Define the paint properties for the thumb
    final Paint paint = Paint()
      ..color = Colors.green // Thumb color
      ..style = PaintingStyle.fill;

    // Define the rounded rectangle thumb
    final Rect rect = Rect.fromCenter(
      center: center,
      width: 50.0,
      height: 30.0,
    );

    final RRect rRect = RRect.fromRectAndRadius(
        rect, const Radius.circular(5.0)); // Adjust corner radius

    // Draw the rounded rectangle thumb
    canvas.drawRRect(rRect, paint);
  }
}

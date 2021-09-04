library no_shimmer;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'
    show DiagnosticPropertiesBuilder, DoubleProperty;

class NoShimmer extends StatelessWidget {
  /// Creates a single colored box
  ///
  /// If [width] is not specified, then it defaults to [BoxConstraints.maxWidth] which can be [double.infinity]
  ///
  /// If [height] is not specified, then it defaults to [BoxConstraints.maxHeight] which can be [double.infinity]
  ///
  /// [color] defaults to `Color(0xFFEEEEEE)` a.k.a `Colors.grey[200]`
  const NoShimmer({
    Key? key,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.color = const Color(0xFFEEEEEE),
    this.clipBehavior,
  })  : assert(width == null || width != -0.0 && width >= 0.0),
        assert(height == null || height != -0.0 && height >= 0.0),
        super(key: key);

  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  /// if not specified, then it defaults to [BoxConstraints.maxWidth] which can be [double.infinity]
  final double? width;

  /// if not specified, then it defaults to [BoxConstraints.maxHeight] which can be [double.infinity]
  final double? height;

  /// defaults to `Colors.grey[200]`
  final Color color;

  /// if [borderRadius] is specified but [clipBehavior] is not, then it defaults to [Clip.antiAlias]
  final Clip? clipBehavior;

  @override
  Widget build(BuildContext context) {
    Widget result = _PlainRect(
      key: key,
      color: color,
      height: height,
      width: width,
    );
    if (borderRadius != null) {
      result = ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: clipBehavior ?? Clip.antiAlias,
        child: result,
      );
    }
    if (padding != null) {
      result = Padding(
        padding: padding!,
        child: result,
      );
    }
    return result;
  }
}

class _PlainRect extends LeafRenderObjectWidget {
  /// a widget that is filled with [color] forming a rectangular object
  /// with the size of [width] x [height]
  const _PlainRect({
    Key? key,
    this.height,
    this.width,
    required this.color,
  })  : assert(width == null || width != -0.0 && width >= 0.0),
        assert(height == null || height != -0.0 && height >= 0.0),
        super(key: key);

  final double? width;
  final double? height;

  /// defaults to `Colors.grey[200]`
  final Color color;

  @override
  _RenderPlainRect createRenderObject(BuildContext context) {
    return _RenderPlainRect(
      color: color,
      height: height,
      width: width,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderPlainRect renderObject) {
    renderObject
      ..color = color
      ..height = height
      ..width = width;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('width', width));
  }
}

class _RenderPlainRect extends RenderBox {
  _RenderPlainRect({
    required Color color,
    required double? height,
    required double? width,
  })  : _color = color,
        _height = height,
        _width = width;

  Color _color;
  Color get color => _color;
  set color(Color newColor) {
    if (newColor == _color) return;

    _color = newColor;
    markNeedsPaint();
  }

  double? _height;
  double? get height => _height;
  set height(double? newHeight) {
    if (newHeight == _height) return;

    _height = newHeight;
    markNeedsLayout();
  }

  double? _width;
  double? get width => _width;
  set width(double? newWidth) {
    if (newWidth == _width) return;

    _width = newWidth;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = width ?? constraints.maxWidth;
    final desiredHeight = height ?? constraints.maxHeight;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    canvas.save();

    final Paint paintRect = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRect(offset & size, paintRect);

    canvas.restore();
  }
}

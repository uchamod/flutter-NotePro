import 'package:flutter/material.dart';

class CustomFabLocation extends FloatingActionButtonLocation {
  final double right;
  final double bottom;

  const CustomFabLocation({
    this.right = 24,
    this.bottom = 24,
  });

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double x = scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width -
        right;

    final double y = scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.floatingActionButtonSize.height -
        bottom;

    return Offset(x, y);
  }
}

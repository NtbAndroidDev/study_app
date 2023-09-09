import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCircleButton extends StatelessWidget {
  const AppCircleButton({super.key,
    required this.child,
    this.color,
    this.onTap,
    this.width = 60
  });

  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        child: child,
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InteractionDetector extends StatelessWidget {
  const InteractionDetector({
    required this.child,
    this.onInteraction,
    Key? key,
  }) : super(key: key);

  final Function(BuildContext)? onInteraction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerEvent details) => onInteraction?.call(context),
      onPointerUp: (PointerEvent details) => onInteraction?.call(context),
      onPointerMove: (PointerEvent details) => onInteraction?.call(context),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class UnlockReveal extends StatefulWidget {
  const UnlockReveal({super.key, required this.child});

  final Widget child;

  @override
  State<UnlockReveal> createState() => _UnlockRevealState();
}

class _UnlockRevealState extends State<UnlockReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1).animate(_fade),
        child: widget.child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AutoSlideUpPanel extends StatefulWidget {
  const AutoSlideUpPanel({
    super.key,
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    this.onPanelSlide,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  final void Function(double)? onPanelSlide;

  @override
  State<AutoSlideUpPanel> createState() => _AutoSlideUpPanelState();
}

class _AutoSlideUpPanelState extends State<AutoSlideUpPanel> with SingleTickerProviderStateMixin {
  late AnimationController _autoSlideUpController;

  @override
  void initState() {
    _autoSlideUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _autoSlideUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _autoSlideUpController,
      child: widget.child,
      builder: (context, child) {
        return SlidingUpPanel(
          minHeight: widget.minHeight * _autoSlideUpController.value,
          maxHeight: widget.maxHeight,
          boxShadow: null,
          color: Colors.transparent,
          panel: child,
          onPanelSlide: widget.onPanelSlide,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class MySnackBar {
  static void show(
      BuildContext context, {
        required String message,
        String? actionLabel,
        VoidCallback? onAction,
        Duration duration = const Duration(seconds: 2),
        Color backgroundColor = Colors.white,
        Color textColor = Colors.green,
      }) {
    final overlay = Overlay.of(context);

    late OverlayEntry entry;

    AnimationController controller;
    Animation<double> fadeAnimation;
    Animation<Offset> slideAnimation;

    controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );

    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: 20,
        right: 20,
        bottom: 50,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (actionLabel != null && onAction != null)
                      TextButton(
                        onPressed: () {
                          onAction();
                          controller.reverse();
                          Future.delayed(
                              const Duration(milliseconds: 300), () {
                            entry.remove();
                          });
                        },
                        child: Text(
                          actionLabel,
                          style: TextStyle(
                            color: Colors.blue.shade300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    controller.forward();

    Future.delayed(duration, () {
      controller.reverse();
      Future.delayed(const Duration(milliseconds: 300), () {
        if (entry.mounted) entry.remove();
      });
    });
  }
}

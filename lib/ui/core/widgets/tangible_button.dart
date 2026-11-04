import 'package:flutter/material.dart';
import 'package:watersort/ui/core/theme/app_colors.dart';

class TangibleButton extends StatefulWidget {
  const TangibleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.height = 56,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final double height;

  @override
  State<TangibleButton> createState() => _TangibleButtonState();
}

class _TangibleButtonState extends State<TangibleButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.isSecondary
        ? const Color(0xFF9B835D)
        : AppColors.accent;
    final isInteractive = widget.onPressed != null;
    final isActive = (_isHovered || _isPressed) && isInteractive;

    // Asymmetric, semi-transparent background color (off-black)
    final buttonBg = isActive
        ? themeColor
        : const Color(0xFF241B2B).withOpacity(0.94);

    final textColor = isActive
        ? const Color(0xFF121212) // Black text when active/hovered
        : const Color(0xFFFFF4D8); // Warm parchment text

    // 3D double-stroke offset at the very bottom (only for active CTA buttons)
    final show3DShadow = !widget.isSecondary && !isActive;

    return MouseRegion(
      onEnter: (_) {
        if (isInteractive) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (isInteractive) setState(() => _isHovered = false);
      },
      child: GestureDetector(
        onTapDown: (_) {
          if (isInteractive) setState(() => _isPressed = true);
        },
        onTapUp: (_) {
          if (isInteractive) {
            setState(() => _isPressed = false);
            if (widget.onPressed != null) widget.onPressed!();
          }
        },
        onTapCancel: () {
          if (isInteractive) setState(() => _isPressed = false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: buttonBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: themeColor,
              width: widget.isSecondary ? 0.8 : 1.4,
            ),
            boxShadow: [
              if (show3DShadow)
                BoxShadow(
                  color: AppColors.accent,
                  offset: const Offset(0, 3.5),
                  blurRadius: 0,
                  spreadRadius: -0.5,
                ),
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text.toUpperCase(),
            style: TextStyle(
              fontFamily: 'BebasNeue',
              color: textColor,
              fontSize:
                  18, // slightly larger font size for BebasNeue because it's narrower
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

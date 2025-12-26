import 'package:flutter/material.dart';

class TapSegment extends StatelessWidget {
  const TapSegment({
    super.key,
    required this.text,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
      onTap: onTap,
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: selected ? selectedColor : Colors.black45,
          ),
        ),
      ),
    );
  }
}

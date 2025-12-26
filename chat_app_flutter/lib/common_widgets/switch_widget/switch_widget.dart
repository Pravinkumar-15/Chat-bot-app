import 'package:chat_app_flutter/common_widgets/switch_widget/tap_segment.dart';
import 'package:chat_app_flutter/constants/constant.dart';
import 'package:chat_app_flutter/global.dart';
import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    super.key,
    this.leftText = 'Left',
    this.rightText = 'Right',
    required this.controller,
    this.onChanged,
    this.activeColor = Colors.black,
  });

  final String leftText;
  final String rightText;
  final ValueNotifier<bool> controller;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;
  void select(bool isRight) {
    if (controller.value == isRight) {
      Global.isClickedHistory.add(true);
      return;
    }
    Global.isClickedHistory.add(false);
    controller.value = isRight;
    onChanged?.call(isRight);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller,
      builder: (context, isRightSelected, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            const double height = 44;
            final double width = constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : (leftText.length + rightText.length) * 9 + 80;

            return SizedBox(
              height: height,
              width: width,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      alignment: isRightSelected
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        heightFactor: 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x22000000),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TapSegment(
                            text: leftText,
                            selected: !isRightSelected,
                            selectedColor: activeColor,
                            onTap: () => select(false),
                          ),
                        ),
                        Expanded(
                          child: TapSegment(
                            text: rightText,
                            selected: isRightSelected,
                            selectedColor: activeColor,
                            onTap: () => select(true),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

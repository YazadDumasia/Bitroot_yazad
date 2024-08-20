import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final onTap;
  bool? isPressed;
  Widget? iconWidget;

  AnimatedButton(
      {super.key,
      required this.onTap,
      required this.isPressed,
      this.iconWidget});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Material(
        color: Colors.transparent,
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isPressed ?? false
                  ? []
                  : [
                      //shadow bottom-right
                      BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(6, 6),
                          blurRadius: 15,
                          spreadRadius: 1),
                      //shadow top-left
                      const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-6, -6),
                          blurRadius: 15,
                          spreadRadius: 1),
                    ],
            ),
            child: iconWidget,
          ),
        ),
      ),
    );
  }
}

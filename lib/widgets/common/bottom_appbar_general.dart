import 'package:flutter/material.dart';

class BottomAppBarGeneral extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;
  final EdgeInsets padding;
  final Color backgroundColor;

  const BottomAppBarGeneral({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 24),
    this.height = 108.0, // Default height
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: height,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Colors.grey.shade300,
            ),
          ),
        ),
        height: height,
        padding: padding,
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

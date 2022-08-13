import 'package:flutter/material.dart';

@immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.children,
    this.height = kToolbarHeight,
  }) : super(key: key);
  
  final List<Widget> children;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [for (final e in children) e],
      ),
    );
  }
}

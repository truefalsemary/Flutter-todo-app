import 'package:flutter/material.dart';

class AppMaterialWrapper extends StatelessWidget {
  const AppMaterialWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: child,
    );
  }
}

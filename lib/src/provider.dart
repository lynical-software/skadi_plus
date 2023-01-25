import 'package:flutter/material.dart';

class SkadiPlusProvider extends InheritedWidget {
  final Widget? imageError;
  final Widget? imagePlaceholder;

  const SkadiPlusProvider({
    required Widget child,
    this.imageError,
    this.imagePlaceholder,
    Key? key,
  }) : super(child: child, key: key);

  static SkadiPlusProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SkadiPlusProvider>();
  }

  @override
  bool updateShouldNotify(SkadiPlusProvider oldWidget) => true;
}

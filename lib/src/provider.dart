import 'package:flutter/material.dart';
import 'package:skadi_plus/src/utils/error_handler.dart';

class SkadiPlusProvider extends InheritedWidget {
  final Widget? imageError;
  final Widget? imagePlaceholder;
  final SkadiErrorDisplay? errorDisplay;

  const SkadiPlusProvider({
    required Widget child,
    this.imageError,
    this.imagePlaceholder,
    this.errorDisplay,
    Key? key,
  }) : super(child: child, key: key);

  static SkadiPlusProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SkadiPlusProvider>();
  }

  @override
  bool updateShouldNotify(SkadiPlusProvider oldWidget) => true;
}

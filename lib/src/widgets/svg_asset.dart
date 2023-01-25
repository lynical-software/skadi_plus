import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../provider.dart';

class SkadiSvgAsset extends StatelessWidget {
  final String asset;
  final double size;
  final Color? bgColor;
  final EdgeInsets padding;
  final Color? iconColor;
  final EdgeInsets? margin;
  final ShapeBorder? shape;
  final BorderSide? side;
  final VoidCallback? onTap;
  final bool _iconOnly;
  final double? width;
  final double? height;
  final Widget? errorPlaceholder;

  ///A Widget to handle a svg in our asset folder
  const SkadiSvgAsset({
    Key? key,
    required this.asset,
    this.size = 24,
    this.iconColor,
    this.bgColor = Colors.transparent,
    this.padding = const EdgeInsets.all(16.0),
    this.shape,
    this.side,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.errorPlaceholder,
  })  : _iconOnly = false,
        super(key: key);

  const SkadiSvgAsset.iconOnly({
    Key? key,
    required this.asset,
    this.size = 18,
    this.iconColor,
    this.bgColor = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.shape,
    this.side,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.errorPlaceholder,
  })  : _iconOnly = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final customShape = shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        );
    final icon = SvgPicture.asset(
      asset,
      width: size,
      height: size,
      color: iconColor ?? Theme.of(context).primaryColor,
      placeholderBuilder: (context) {
        return errorPlaceholder ??
            SkadiPlusProvider.of(context)?.imageError ??
            const SizedBox.shrink();
      },
    );
    // color: iconColor,
    // width: size,
    // height: size,

    if (_iconOnly) {
      return icon;
    }
    final child = Card(
      shape: customShape,
      color: bgColor,
      elevation: 0.0,
      margin: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        customBorder: customShape,
        child: Padding(
          padding: padding,
          child: icon,
        ),
      ),
    );
    if (width != null && height != null) {
      return SizedBox(width: width, height: height, child: child);
    }
    return child;
  }
}

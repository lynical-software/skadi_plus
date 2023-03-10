import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../provider.dart';

class SkadiNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final BorderRadius radius;
  final Widget? loading;
  final Widget? error;
  final double? width;
  final double? height;
  final Color? color;
  const SkadiNetworkImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.radius = BorderRadius.zero,
    this.loading,
    this.error,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = SkadiPlusProvider.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: radius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          color: color,
          colorBlendMode: BlendMode.darken,
          errorWidget: (context, err, obj) {
            if (error != null) return error!;
            return provider?.imageError ?? const Icon(Icons.error_outline);
          },
          placeholder: (context, data) {
            if (loading != null) return loading!;
            return provider?.imagePlaceholder ??
                const Icon(Icons.image_rounded);
          },
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'app_circular_progress_indicator.dart';

class DefaultCashedImage extends StatelessWidget {
  const DefaultCashedImage({
    Key? key,
    required this.height,
    required this.width,
    required this.loadingIndicatorSize,
    required this.imageUrl,
  }) : super(key: key);

  final double height;
  final double width;
  final double loadingIndicatorSize;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Image(image: imageProvider),
      placeholder: (context, url) => Center(
        child: AppCircularProgressIndicator(
          width: loadingIndicatorSize,
          height: loadingIndicatorSize,
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: SizedBox(
          width: loadingIndicatorSize,
          height: loadingIndicatorSize,
          child: const CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

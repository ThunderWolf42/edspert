import 'package:flutter/material.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const ImageNetworkWidget({
    super.key,
    this.height,
    required this.imageUrl,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        height: height,
        width: width,
        color: Colors.grey,
      ),
    );
  }
}

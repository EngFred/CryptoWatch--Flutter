import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoinImage extends StatelessWidget {
  final String url;
  final double size;

  const CoinImage({super.key, required this.url, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Container(color: Colors.grey[800], width: size, height: size),
        errorWidget: (context, url, error) =>
            Icon(Icons.error, color: Colors.red, size: size),
      ),
    );
  }
}

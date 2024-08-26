import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(10 / 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04), // Light gray background
        borderRadius: const BorderRadius.all(
          Radius.circular(10), // Rounded corners
        ),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04), // Light background matching the theme color
        shape: BoxShape.circle, // Circular shape
      ),
    );
  }
}

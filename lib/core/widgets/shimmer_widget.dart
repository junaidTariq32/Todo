import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:to_do/core/shared/app_colors.dart';

class ShimmerView extends StatelessWidget {
  const ShimmerView({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
            baseColor: AppColors.kcStroke,
            highlightColor: AppColors.kcStroke.withOpacity(0.2),
            child: Container(
              height: height,
              width: width,
              color: AppColors.kcStroke,
            ))
        .decorated(borderRadius: const BorderRadius.all(Radius.circular(12)))
        .padding(all: 8);
  }
}

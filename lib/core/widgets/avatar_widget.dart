import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/app_styles.dart';

class AvatarView extends StatelessWidget {
  final double height;
  final double widget;
  final String path;
  final String userName;
  final BoxFit fit;

  const AvatarView(
      {Key? key,
      this.height = 48,
      this.widget = 48,
      required this.path,
      required this.userName,
      this.fit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: const CircleBorder(),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.kcPrimaryColor,
            borderRadius: BorderRadius.circular(AppStyles.kRadiusMedium)),
        height: height,
        width: widget,
        child:  path.isEmpty
            ? _buildLetter(context)
            : _buildProfileImageView(context, path),
      ),
    );
  }

  Widget _buildProfileImageView(BuildContext context, String url) => ClipRRect(
        borderRadius: BorderRadius.circular(AppStyles.kRadiusMedium),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: path,
        ),
      );

  Widget _buildLetter(BuildContext context) => Center(
        child: Text(
          userName[0].toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold, color: AppColors.kcTextSecondary),
        ),
      );
}

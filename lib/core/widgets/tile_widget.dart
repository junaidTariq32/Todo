import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/app_colors.dart';
import '../shared/app_styles.dart';

class TileWidget extends StatelessWidget {
  final String header;
  final String subHeader;
  final IconData icon;
  final Color primaryColor;
  final VoidCallback onTap;
  final bool isDark;

  const TileWidget(
      {Key? key,
      required this.header,
      required this.subHeader,
      required this.icon,
      required this.primaryColor,
      required this.onTap,
      required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * .15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  color: isDark ? Colors.white24 : Colors.black12,
                  offset: const Offset(0.0, 4.0))
            ],
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [0.1, 0.5, 0.7, 0.9],
              colors: [
                primaryColor.withOpacity(0.6),
                primaryColor.withOpacity(0.7),
                primaryColor.withOpacity(0.8),
                primaryColor.withOpacity(0.9),
              ],
            )),
        child: Stack(
          children: [
            Positioned(
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(
                          icon,
                          size: 18,
                          color: Colors.white,
                        ).paddingAll(8)),
                    AppStyles.vSpaceSmall,
                    AutoSizeText(
                      header,
                      maxLines: 1,
                      style: AppStyles.kBodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.kAltWhite),
                    )
                  ],
                )),
            Positioned(
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    subHeader,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: AppStyles.kHeading2Style.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ).paddingAll(8),
      ),
    );
  }
}

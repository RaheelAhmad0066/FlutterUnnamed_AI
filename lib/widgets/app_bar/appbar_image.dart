import 'package:aichat/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:aichat/core/utils/size_utils.dart';

import '../custom_image_view.dart';

// ignore: must_be_immutable
class AppbarImage extends StatelessWidget {
  AppbarImage({
    Key? key,
    this.imagePath,
    this.svgPath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  String? svgPath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Opacity(
          opacity: 0.5,
          child: CustomImageView(
            svgPath: svgPath,
            imagePath: imagePath,
            height: 38.v,
            width: 39.h,
            color: appTheme.whiteA700,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

import 'package:aichat/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../custom_image_view.dart';

// ignore: must_be_immutable
class AppbarImage1 extends StatelessWidget {
  AppbarImage1({
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
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

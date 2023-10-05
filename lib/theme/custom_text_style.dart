import 'package:aichat/core/utils/size_utils.dart';
import 'package:aichat/theme/theme_helper.dart';
import 'package:flutter/material.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );
  static get bodyLargeOnPrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 16.fSize,
      );
  static get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.6),
      );
  static get bodyLargePrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 16.fSize,
      );
  static get bodyLargePrimaryContainer16 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 16.fSize,
      );
  static get bodyLargePrimaryContainer17 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 17.fSize,
      );
  static get bodyLargePrimaryContainer17_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 17.fSize,
      );
  static get bodyLargePrimary_1 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodyLargeWhiteA700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodyLargeWhiteA70016 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 16.fSize,
      );
  static get bodyLargeWhiteA700_1 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700.withOpacity(0.53),
      );
  // Headline text style
  static get headlineMediumWhiteA700 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  // Title text style
  static get titleLarge20 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 20.fSize,
      );
  static get titleLarge21 => theme.textTheme.titleLarge!
      .copyWith(fontSize: 20.fSize, color: Colors.black);
  static get titleLargePrimary => theme.textTheme.titleLarge!.copyWith(
        color: Colors.black,
        fontSize: 20.fSize,
      );
}

extension on TextStyle {
  TextStyle get abel {
    return copyWith(
      fontFamily: 'Abel',
    );
  }
}

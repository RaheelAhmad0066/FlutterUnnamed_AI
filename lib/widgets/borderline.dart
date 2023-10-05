import 'package:flutter/material.dart';
import 'package:aichat/core/utils/size_utils.dart';

// ignore: must_be_immutable
class borderline extends StatelessWidget {
  borderline({super.key, required this.color});
  Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 5.h,
        width: 110.v,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

import 'package:chat/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String iconName;
  final Color? iconColor;
  final double? height;
  final double? width;
  const SvgIcon({
    super.key,
    required this.iconName,
    this.iconColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconName,
      width: width ?? 24,
      height: height ?? 24,
      colorFilter: ColorFilter.mode(
        iconColor ?? AppColors.black,
        BlendMode.srcIn,
      ),
    );
  }
}

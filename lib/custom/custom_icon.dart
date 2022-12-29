import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_dimensions.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? size;
  final double? radius;

  const CustomIcon({Key? key,
    required this.icon,
    this.iconColor = const Color(0xFF000000),
    this.size = 0,
    this.backgroundColor = const Color(0xFFffffff),
    this.radius = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: radius==0?AppDimensions.radius24:radius,
      child: Icon(
        icon,
        size: size == 0 ? AppDimensions.icon30 : size,
        color: iconColor,
      ),
    );
  }
}

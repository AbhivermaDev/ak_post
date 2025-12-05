import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class OutLine extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final FontWeight fontWeight;

  /// 🔥 icon optional
  final IconData? icon;
  final double iconSize;
  final Color? iconColor;

  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final bool isLoading;

  const OutLine({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius = 14.0,
    this.paddingVertical = 16.0,
    this.paddingHorizontal = 24.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.iconSize = 22.0,
    this.iconColor,
    this.margin,
    this.height,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? const Color(0xFF2D6A4F);
    final contentColor = textColor ?? Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                buttonColor,
                buttonColor.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Container(
            margin: margin,
            padding: EdgeInsets.symmetric(
              vertical: paddingVertical,
              horizontal: paddingHorizontal,
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Icon(
                      icon!,
                      size: iconSize,
                      color: iconColor ?? contentColor,
                    ),

                  if (icon != null) const SizedBox(width: 10),

                  Flexible(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: contentColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class LightButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final FontWeight fontWeight;
  final IconData? icon;
  final double iconSize;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final bool isLoading;

  const LightButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderColor,
    this.borderRadius = 14.0,
    this.paddingVertical = 16.0,
    this.paddingHorizontal = 24.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.iconSize = 22.0,
    this.margin,
    this.height,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = color ?? Colors.white;
    final Color contentColor = textColor ?? const Color(0xFF2D6A4F);
    final Color borderClr = borderColor ?? const Color(0xFF2D6A4F);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: contentColor.withOpacity(0.1),
        highlightColor: contentColor.withOpacity(0.05),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderClr,
              width: 2,
            ),
          ),
          child: Container(
            margin: margin,
            padding: EdgeInsets.symmetric(
              vertical: paddingVertical,
              horizontal: paddingHorizontal,
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: contentColor,
                ),
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Icon(icon, size: iconSize, color: contentColor),
                  if (icon != null) const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: contentColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
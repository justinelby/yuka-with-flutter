import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../colors.dart';

class OFFAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final String title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Brightness? brightness;
  final IconThemeData? iconTheme;
  final TextTheme? textTheme;
  final bool primary;
  final bool? centerTitle;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  @override
  final Size preferredSize;

  OFFAppBar(
      {required this.title,
      Key? key,
      this.leading,
      this.automaticallyImplyLeading = true,
      this.actions,
      this.flexibleSpace,
      this.bottom,
      this.elevation = 4.0,
      this.brightness,
      this.iconTheme,
      this.textTheme,
      this.primary = true,
      this.centerTitle,
      this.titleSpacing = NavigationToolbar.kMiddleSpacing,
      this.toolbarOpacity = 1.0,
      this.bottomOpacity = 1.0})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBarTheme appBarTheme = AppBarTheme.of(context);

    return NewGradientAppBar(
      gradient: LinearGradient(
        colors: <Color>[
          AppColors.toolbarGradientStart,
          AppColors.toolbarGradientEnd
        ],
        begin: AlignmentDirectional.centerEnd,
        end: AlignmentDirectional.centerStart,
      ),
      title: Text(title, style: appBarTheme.textTheme?.headline6),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      brightness: brightness,
      iconTheme: iconTheme,
      textTheme: textTheme,
      primary: primary,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
    );
  }
}

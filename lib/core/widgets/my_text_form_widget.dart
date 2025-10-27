import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/strings/enum_manager.dart';

import '../strings/app_color_manager.dart';
import '../util/my_style.dart';

class MyTextFormOutLineWidget extends StatefulWidget {
  const MyTextFormOutLineWidget({
    super.key,
    this.label = '',
    this.hint = '',
    this.helperText = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color = Colors.black,
    this.initialValue,
    this.textDirection,
    this.validator,
    this.iconWidget,
    this.iconWidgetLift,
    this.onChangedFocus,
    this.onTap,
    this.autofillHints,
    this.labelText,
  });

  final bool? enable;
  final String label;
  final String? labelText;
  final String hint;
  final String? helperText;
  final dynamic icon;
  final Widget? iconWidget;
  final Widget? iconWidgetLift;
  final Color color;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final Function(bool)? onChangedFocus;
  final Function()? onTap;
  final List<String>? autofillHints;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  State<MyTextFormOutLineWidget> createState() => _MyTextFormOutLineWidgetState();
}

class _MyTextFormOutLineWidgetState extends State<MyTextFormOutLineWidget> {
  @override
  Widget build(BuildContext context) {
    final padding = widget.innerPadding ?? const EdgeInsets.symmetric(horizontal: 20.0).w;

    bool obscureText = widget.obscureText;
    Widget? suffixIcon;
    Widget? eye;
    VoidCallback? onChangeObscure;

    if (widget.iconWidget != null) {
      suffixIcon = widget.iconWidget!;
    } else if (widget.icon != null) {
      suffixIcon = Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0).r,
        child: ImageMultiType(
          color: AppColorManager.mainColor,
          url: widget.icon!,
          height: 15.0.r,
          width: 15.0.r,
        ),
      );
    }

    if (obscureText) {
      eye = StatefulBuilder(builder: (context, state) {
        return IconButton(
            splashRadius: 0.01,
            onPressed: () {
              state(() => obscureText = !obscureText);
              if (onChangeObscure != null) onChangeObscure!();
            },
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ));
      });
    }

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColorManager.cardColor),
      borderRadius: BorderRadius.circular(10.0.r),
    );

    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColorManager.red,
        width: 1.0.spMin,
      ),
      borderRadius: BorderRadius.circular(10.0.r),
    );

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: errorBorder,
      border: border,
      focusedBorder: border,
      enabledBorder: border,
      helperText: widget.helperText,
      helperStyle: const TextStyle(color: Colors.grey),
      fillColor: AppColorManager.f9,
      label: DrawableText(
        text: widget.label,
        color: AppColorManager.grey,
        size: 16.0.spMin,
      ),
      counter: const SizedBox(),
      hintText: widget.hint,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintTextDirection: widget.textDirection,
      hintStyle: TextStyle(
        color: AppColorManager.grey,
        fontSize: 14.0.sp,
        fontFamily: FontManager.semeBold.name,
      ),
      filled: false,
      labelStyle: TextStyle(color: widget.color),
      prefixIcon: widget.iconWidget ?? suffixIcon,
      suffixIcon: widget.iconWidgetLift ?? eye,
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.semeBold.name,
      fontSize: 16.0.spMin,
      color: AppColorManager.black,
    );

    return StatefulBuilder(builder: (context, state) {
      onChangeObscure = () => state(() {});
      return Column(
        children: [
          if (widget.labelText != null)
            DrawableText(
              text: widget.labelText!,
              // color: AppColorManager.gray,
              fontFamily: FontManager.semeBold.name,
              size: 16.0.spMin,
              padding: EdgeInsets.only(bottom: 10.0).r,
              matchParent: true,
            ),
          TextFormField(
            autofillHints: widget.autofillHints,
            onTap: () => widget.onTap?.call(),
            validator: widget.validator,
            decoration: inputDecoration,
            maxLines: widget.maxLines,
            readOnly: !(widget.enable ?? true),
            initialValue: widget.initialValue,
            obscureText: obscureText,
            textAlign: widget.textAlign,
            onChanged: widget.onChanged,
            style: textStyle,
            textDirection: widget.textDirection,
            maxLength: widget.maxLength,
            controller: widget.controller,
            keyboardType: widget.keyBordType,
          ),
        ],
      );
    });
  }
}

class MyEditTextWidget extends StatelessWidget {
  const MyEditTextWidget({
    super.key,
    this.hint = '',
    this.maxLines = 1,
    this.textAlign,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.backgroundColor,
    this.focusNode,
    this.obscureText = false,
    this.icon,
    this.enable,
    this.radios,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String hint;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final bool? enable;
  final TextAlign? textAlign;
  final Function(String val)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final Color? backgroundColor;
  final Widget? icon;
  final FocusNode? focusNode;
  final double? radios;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    bool obscureText = this.obscureText;
    Widget? suffixIcon;
    late VoidCallback onChangeObscure;

    if (icon != null) suffixIcon = icon;

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              state(() => obscureText = !obscureText);
              onChangeObscure();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
              child: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                size: 20.0.spMin,
              ),
            ));
      });
    }

    final border = OutlineInputBorder(
        borderSide: BorderSide(
          color: backgroundColor ?? AppColorManager.offWhit.withValues(alpha: 0.27),
        ),
        borderRadius: BorderRadius.circular(radios ?? 10.0.r));

    final inputDecoration = InputDecoration(
      hintText: hint,
      hintStyle: MyStyle.hintStyle,
      contentPadding: innerPadding ?? const EdgeInsets.symmetric(horizontal: 10.0).w,
      counter: const SizedBox(),
      enabledBorder: border,
      focusedErrorBorder: border,
      disabledBorder: border,
      focusedBorder: border,
      errorMaxLines: 0,
      constraints: BoxConstraints(maxWidth: .9.sw, minWidth: .3.sw),
      border: border,
      fillColor: backgroundColor ?? AppColorManager.offWhit.withValues(alpha: 0.27),
      filled: true,
      enabled: enable ?? true,
      prefixIcon: suffixIcon ?? 0.0.verticalSpace,
      prefixIconConstraints: BoxConstraints(maxWidth: 80.0.spMin, minHeight: 50.0.spMin),
    );

    return StatefulBuilder(
      builder: (context, state) {
        onChangeObscure = () => state(() {});
        return TextFormField(
          obscureText: obscureText,
          decoration: inputDecoration,
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.start,
          onChanged: onChanged,
          style: MyStyle.textFormTextStyle,
          focusNode: focusNode,
          maxLength: maxLength,
          controller: controller,
          keyboardType: keyBordType,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
        );
      },
    );
  }
}

class RectCustomClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(3.w, 0, size.width - 6.w, size.height);

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => oldClipper != this;
}

class MyEditTextWidgetWhite extends StatelessWidget {
  const MyEditTextWidgetWhite({
    super.key,
    this.hint = '',
    this.maxLines = 1,
    this.textAlign,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.backgroundColor,
    this.focusNode,
    this.obscureText = false,
    this.icon,
    this.enable,
    this.radios,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String hint;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final bool? enable;
  final TextAlign? textAlign;
  final Function(String val)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final Color? backgroundColor;
  final Widget? icon;
  final FocusNode? focusNode;
  final double? radios;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    bool obscureText = this.obscureText;
    Widget? suffixIcon;
    late VoidCallback onChangeObscure;

    if (icon != null) suffixIcon = icon;

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              state(() => obscureText = !obscureText);
              onChangeObscure();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
              child: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                size: 20.0.spMin,
              ),
            ));
      });
    }

    final border = OutlineInputBorder(
        borderSide: BorderSide(
          color: backgroundColor ?? AppColorManager.offWhit.withValues(alpha: 0.27),
        ),
        borderRadius: BorderRadius.circular(radios ?? 10.0.r));

    final inputDecoration = InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: FontManager.semeBold.name,
        fontSize: 18.0.spMin,
        color: Colors.white54,
      ),
      contentPadding: innerPadding ?? const EdgeInsets.symmetric(horizontal: 10.0).w,
      counter: const SizedBox(),
      enabledBorder: border,
      focusedErrorBorder: border,
      disabledBorder: border,
      focusedBorder: border,
      errorMaxLines: 0,
      constraints: BoxConstraints(maxWidth: .9.sw, minWidth: .3.sw),
      border: border,
      fillColor: backgroundColor ?? AppColorManager.offWhit.withValues(alpha: 0.27),
      filled: true,
      enabled: enable ?? true,
      prefixIcon: suffixIcon ?? 0.0.verticalSpace,
      prefixIconConstraints: BoxConstraints(maxWidth: 80.0.spMin, minHeight: 50.0.spMin),
    );

    return StatefulBuilder(
      builder: (context, state) {
        onChangeObscure = () => state(() {});
        return TextFormField(
          obscureText: obscureText,
          decoration: inputDecoration,
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.start,
          onChanged: onChanged,
          style: TextStyle(
            fontFamily: FontManager.bold.name,
            fontSize: 18.0.spMin,
            color: Colors.white,
          ),
          cursorColor: Colors.white,
          focusNode: focusNode,
          maxLength: maxLength,
          controller: controller,
          keyboardType: keyBordType,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
        );
      },
    );
  }
}

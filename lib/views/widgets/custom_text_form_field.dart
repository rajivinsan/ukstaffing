import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.controller,
      this.label,
      this.prefix,
      this.suffix,
      this.validator,
      this.prefixICon,
      this.obscureText,
      this.sufficIcon,
      this.inputType,
      this.textInputAction,
      this.enable = true});
  final String? label;
  final TextEditingController? controller;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixICon;
  final Widget? sufficIcon;
  final bool? enable;
  bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      enabled: enable,
      validator: validator,

      obscureText: obscureText ?? false,
      keyboardType: inputType ?? TextInputType.name,
      // style: textFiledStyle,
      decoration: InputDecoration(
        prefixIcon: prefixICon,
        suffixIcon: sufficIcon,
        suffix: suffix,
        fillColor: containerBackGroundColor,
        filled: true,
        hintText: label!.capitalize(),
        hintStyle: sourceCodeProStyle.copyWith(
            color: lightTextColor, fontWeight: FontWeight.normal),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(0.0)),
          borderSide: BorderSide(
            color: const Color(0xff012213).withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(0.0)),
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(0.0),
          ),
          borderSide: BorderSide(
            color: const Color(0xff012213).withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}

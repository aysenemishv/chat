import 'package:chat/const/app_colors.dart';
import 'package:chat/const/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final String hintText;
  final BorderRadius borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final Function(PointerDownEvent)? onTapOutside;
  final TextEditingController textEditingController;
  final List<TextInputFormatter>? formatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.focusNode,
    required this.borderRadius,
    required this.hintText,
    required this.onTap,
    required this.onTapOutside,
    this.prefixIcon,
    this.suffixIcon,
    required this.textEditingController,
    this.formatters,
    this.keyboardType,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      validator: validator,
      keyboardType: keyboardType,
      focusNode: focusNode,
      controller: textEditingController,
      cursorColor: AppColors.blue,
      cursorHeight: 20,
      inputFormatters: formatters,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        hintText: hintText,
        hintStyle: AppTextStyles.s17w400clGrey,
        prefixIcon: prefixIcon,
        prefixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: suffixIcon,
        ),
        suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
        filled: true,
        fillColor: AppColors.blackWithOpacity5,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide.none,
        ),
      ),
      onTap: onTap,
      onTapOutside: onTapOutside,
    );
  }
}

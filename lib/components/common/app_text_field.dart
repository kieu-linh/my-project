import 'package:flutter/material.dart';
import 'package:my_project/constants/app_colors.dart';
import 'package:my_project/utils/validators.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final int maxLines;
  final bool enabled;
  final void Function(String)? onChanged;

  const AppTextField({
    Key? key,
    this.controller,
    this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.obscure = false,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.maxLines = 1,
    this.enabled = true,
    this.onChanged,
  }) : super(key: key);

  // Convenience factory constructors for common use cases
  factory AppTextField.email({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? label,
    Widget? suffixIcon,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint ?? 'Enter email',
      label: label ?? 'Email',
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: Validators.email,
      onSaved: onSaved,
      onChanged: onChanged,
      suffixIcon: suffixIcon,
    );
  }

  factory AppTextField.password({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? label,
    bool obscure = true,
    Widget? suffixIcon,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint ?? 'Enter password',
      label: label ?? 'Password',
      prefixIcon: Icons.lock_outlined,
      obscure: obscure,
      validator: Validators.basic,
      onSaved: onSaved,
      onChanged: onChanged,
      suffixIcon: suffixIcon,
    );
  }

  factory AppTextField.required({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? label,
    IconData? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint,
      label: label,
      prefixIcon: prefixIcon,
      keyboardType: keyboardType,
      validator: Validators.basic,
      onSaved: onSaved,
      onChanged: onChanged,
      suffixIcon: suffixIcon,
    );
  }

  factory AppTextField.phone({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? label,
    Widget? suffixIcon,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint ?? 'Enter phone number',
      label: label ?? 'Phone',
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      validator: Validators.mobile,
      onSaved: onSaved,
      onChanged: onChanged,
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.greyDark,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          validator: validator,
          onSaved: onSaved,
          maxLines: maxLines,
          enabled: enabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.grey),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.primary)
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.greyLight.withValues(alpha: 0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}

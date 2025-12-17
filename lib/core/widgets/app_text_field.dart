// ============================================================================
//                               APP TEXT FIELD
// ============================================================================
// A reusable, app-wide text form field widget.
//
// PURPOSE:
// - Centralizes TextFormField styling and behavior.
// - Ensures consistent UI and validation usage across the app.
// - Works seamlessly with the app validators file (single source of truth).
//
// DESIGN PRINCIPLES:
// - Stateless and UI-only (no business logic).
// - Follows Single Responsibility Principle (SRP):
//   this widget is responsible ONLY for input rendering and decoration.
// - Validation logic is injected via `validator` and never defined here.
//
// VALIDATION:
// - Accepts a validator function: `String? Function(String?)?`
// - Validation rules must come from the validators file.
// - `null` return value = valid input.
//
// CONFIGURABILITY:
// - Supports obscured text (passwords).
// - Supports custom keyboard types, input formatters, and max length.
// - Allows text alignment and custom text style.
// - Provides optional hint text.
//
// STYLING:
// - Consistent borders for normal, focused, and error states.
// - Uses filled background for better UX.
// - Avoids inline styling in screens by centralizing design here.
//
// USAGE RULES:
// - Do NOT add validation logic inside this widget.
// - Do NOT perform state management here.
// - Control input state via external controllers and Cubit/Form logic.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final String? hintText;

  const AppTextField({
    super.key,
    required this.label,
    this.obscure = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textAlign,
    this.maxLength,
    this.inputFormatters,
    this.style,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      keyboardType: keyboardType,
      textAlign: textAlign ?? TextAlign.start,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      style: style ?? const TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

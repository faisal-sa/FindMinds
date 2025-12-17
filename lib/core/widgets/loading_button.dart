// ============================================================================
//                               LOADING BUTTON
// ============================================================================
// A reusable button widget with a built-in loading state.
//
// PURPOSE:
// - Prevents multiple taps while an async action is running.
// - Replaces the button label with a loading indicator when `isLoading = true`.
//
// DESIGN NOTES:
// - Stateless and UI-only (no business logic).
// - Follows Single Responsibility Principle:
//   this widget ONLY handles button UI + loading state.
// - Safe to reuse across the app (Auth, Payments, Forms, etc.).
//
// BEHAVIOR:
// - When `isLoading` is true:
//   • Button is disabled (onPressed = null)
//   • CircularProgressIndicator is shown instead of text
// - When `isLoading` is false:
//   • Button is enabled
//   • Text label is shown
//
// PARAMETERS:
// - text            : Button label when not loading
// - onPressed       : Callback when button is pressed
// - isLoading       : Controls loading state (default: false)
// - backgroundColor : Optional custom background color
// - foregroundColor : Optional text / loader color
// - padding         : Optional internal padding
// - borderRadius    : Optional corner radius
//
// USAGE:
// - Control `isLoading` from Cubit / State
// - Do NOT put async logic inside this widget
// ============================================================================

import 'package:flutter/material.dart';

Widget loadingBtn({
  required String text,
  required VoidCallback? onPressed,
  bool isLoading = false,
  Color? backgroundColor,
  Color? foregroundColor,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
}) {
  return ElevatedButton(
    onPressed: isLoading ? null : onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.blue,
      foregroundColor: foregroundColor ?? Colors.white,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
      ),
    ),
    child: isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
  );
}

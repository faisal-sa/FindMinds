import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final String? label;
  final IconData? icon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool isPassword;

  const CustomTextField({
    super.key,
    this.hint = '',
    this.label,
    this.icon,
    this.onChanged,
    this.validator,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              // CHANGE 1: Removed .sp.
              // 14 logical pixels looks good on both Mobile and Web/Desktop.
              fontSize: 14, 
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          // CHANGE 2: .h is usually fine, but a fixed 8 is safer for resizing
          const SizedBox(height: 8), 
        ],

        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: isPassword,
          style: const TextStyle(
            // CHANGE 3: Removed .sp to prevent text explosion on wide screens
            fontSize: 14,
            color: Color(0xFF334155),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              // CHANGE 4: Removed .sp
              fontSize: 14,
            ),
            prefixIcon: icon != null
                ? Icon(
                    icon,
                    // CHANGE 5: Removed .sp. Icons should stay 20px fixed.
                    size: 20,
                    color: Colors.grey[500],
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            
            // CHANGE 6: IMPORTANT
            // Removed .w and .h.
            // Using 16.w on a desktop monitor creates massive padding.
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            
            border: OutlineInputBorder(
              // CHANGE 7: .r is okay, but fixed 12 is often cleaner on resize
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black87, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

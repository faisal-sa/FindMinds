import 'package:flutter/material.dart';
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
             
              fontSize: 14, 
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
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
            fontSize: 14,
            color: Color(0xFF334155),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            prefixIcon: icon != null
                ? Icon(
                    icon,
                    size: 20,
                    color: Colors.grey[500],
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            
         
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            
            border: OutlineInputBorder(
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

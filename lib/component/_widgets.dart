import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign textAlign;

  const CustomTextField({
    super.key,
    this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55, // fixed height for consistency
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        textAlign: textAlign,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        cursorColor: const Color(0xFF286243),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixIcon != null
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: prefixIcon,
          )
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: suffixIcon,
          )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ), // vertical=0 works with TextAlignVertical.center
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
            const BorderSide(color: Color(0xFFC2E96A), width: 1.5),
          ),
        ),
      ),
    );
  }
}



/// appbar -
appBranding (){
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 26,
          height: 26,
          child: Image.asset('assets/logo/authLogo.png'),
        ),
        const SizedBox(width: 5),
        const Text(
          'Auth.Co',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF286243),
          ),
        ),
      ],
    ),
  );
}





import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField(
      {super.key,
      required this.controller,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.prefixIconConstraints,
      this.suffixIconConstraints,
      this.errorText,
      this.errorStyle,
      this.onChanged,
      this.isPassword = false,
     this. readOnly=false,
      this.validator,
      this.onTap});
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final String? errorText;
  final TextStyle? errorStyle;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? isPassword;
  final bool  readOnly;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 46,
          // padding: const EdgeInsets.symmetric(
          //     horizontal: 8), // Optional: for internal padding
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the TextField
            borderRadius: BorderRadius.circular(30.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 10, // Blur radius
                offset: const Offset(0, 5), // Vertical offset of shadow
              ),
            ],
          ),
          
        ), TextFormField(onTap:onTap,
          readOnly: readOnly,
            validator: validator,
            obscureText: isPassword!,
            onChanged: onChanged,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(end: 12.0),
                child: suffixIcon,
              ),
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                gapPadding: 4,
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[700]),
              fillColor: Colors.white70,
              contentPadding:
                  const EdgeInsetsDirectional.only(start: 12, bottom: 9),
            //  errorStyle: TextStyle(height: 3.5),
              // errorBorder: OutlineInputBorder( 
              //   borderRadius: BorderRadius.circular(30.0),
              //   borderSide: BorderSide(color: Colors.red, width: 1.0),
              // ),
            ),
          ),
      ],
    );
  }
}

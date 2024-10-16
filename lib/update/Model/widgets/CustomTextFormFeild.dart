import 'package:flutter/material.dart';


import '../../../consts/Colors.dart';


class CutomTextFromFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final Widget suffix;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final bool readOnly;
  final bool autocorrect;
  final Color colorBorder;

  const CutomTextFromFeild({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.suffix,
    required this.keyboardType,
    required this.textInputAction,
    required this.onChanged,
    required this.validator,
    required this.obscureText,
    required this.readOnly,
    required this.autocorrect, required this.colorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        readOnly: readOnly,
        autocorrect: autocorrect,
        style: const TextStyle(color: AppColors.darkTertiaryColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.gery, // Grey background
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(color: AppColors.darkTertiaryColor),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          suffix: suffix,
          border: authOutlineInputBorder, // Uses the border without a visible side
          enabledBorder: authOutlineInputBorder,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:  colorBorder , // No visible border side
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(100)), // Keeps rounded shape
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.transparent , // No visible border side
    width: 1,
  ),
  borderRadius: BorderRadius.all(Radius.circular(100)), // Keeps rounded shape
);




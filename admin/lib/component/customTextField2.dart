// ignore: file_names
import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';

// ignore: must_be_immutable
class CustomTextFeild2 extends StatefulWidget {
  final String? prefiximagePath;
  final String? suffiximagePath;
  final String? hintText;
  final Function(String)? validator;
  final TextInputType? textInputType;

  bool? obscureText;
  final Color? borderColor; // New property for border color
  final Function(String)? onChanged;

  CustomTextFeild2({
    Key? key,
    this.prefiximagePath,
    this.hintText,
    this.suffiximagePath,
    this.obscureText,
    this.borderColor = Colors.white, // Required border color
    this.onChanged,
    this.validator,
    this.textInputType,
  }) : super(key: key);

  @override
  State<CustomTextFeild2> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild2> {
  String? _errorText;
  TextInputType getKeyboardType() {
    // Return the appropriate keyboard type based on the case
    if (widget.obscureText == true) {
      // Case where the keyboard should be numbers-only
      return TextInputType.number;
    } else {
      // Case where the keyboard should be the normal keyboard
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        // Call the custom validator function if provided
        if (widget.validator != null) {
          final error = widget.validator!(value ?? 'UUU');
          setState(() {
            _errorText = error; // Update the error message
          });
          return error;
        }
        return null; // Return null if no custom validation is provided
      },
      // (data) {
      //   if (data!.isEmpty) {
      //     return 'Field is Required';
      //   }
      // },
      onChanged: widget.onChanged,
      keyboardType: widget.textInputType,

      obscureText: widget.obscureText!,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 239, 240, 241),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: widget.borderColor!), // Set border color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: widget.borderColor!),
        ),
        hintText: widget.hintText,
        suffixIcon: widget.suffiximagePath != null
            ? GestureDetector(
                child: Image.asset(widget.suffiximagePath!),
                onTap: () => setState(() {
                  widget.obscureText = !widget.obscureText!;
                }),
              )
            : null,
        prefixIcon: widget.prefiximagePath != null
            ? Image.asset(widget.prefiximagePath!)
            : null,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 176, 176, 176),
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamilyString,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 50,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 50,
          minWidth: 60,
        ),
      ),
    );
  }
}

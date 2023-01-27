import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String obscuringCharacter;
  final int? maxLength;
  final String? counterText;
  final bool enabled;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsets scrollPadding;
  final EdgeInsets contentPadding;
  final bool errorDisplaying;
  final TextCapitalization textCapitalization;
  final Color? fillColor;
  final int? minLines;
  final int? maxLines;

   const CustomTextField(
      {Key? key,
        this.controller,
        this.hintText,
        this.style = const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          letterSpacing: 1.2,
        ),
        this.hintStyle = const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          letterSpacing: 1,
        ),
        this.onChanged,
        this.validator,
        this.onSaved,
        this.inputFormatters,
        this.focusNode,
        this.autofocus = false,
        this.keyboardType,
        this.obscureText = false,
        this.obscuringCharacter = '•',
        this.maxLength,
        this.counterText,
        this.enabled = true,
        this.textAlign = TextAlign.start,
        this.prefixIcon,
        this.suffixIcon,
        this.prefix,
        this.suffix,
        this.errorDisplaying = false,
        this.scrollPadding = const EdgeInsets.all(20.0),
        this.contentPadding = const EdgeInsets.all(10.0),
        this.textCapitalization = TextCapitalization.none,
        this.fillColor,
        this.minLines,
        this.maxLines,
      })
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: widget.style,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding: widget.contentPadding,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(6.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(6.0),
        ),
        hintText: widget.hintText,
        counterText: widget.counterText,
        hintStyle: widget.hintStyle,
        // labelStyle: ,
        enabled: widget.enabled,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        prefix: widget.prefix,
        suffix: widget.suffix,
        errorStyle: const TextStyle(),
      ),
      textAlign: widget.textAlign,
      autofocus: widget.autofocus,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      maxLength: widget.maxLength,
      onSaved: widget.onSaved,
      validator: widget.validator,
      scrollPadding: widget.scrollPadding,
      textCapitalization: widget.textCapitalization,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
    );
  }
}

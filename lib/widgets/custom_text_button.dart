import 'package:flutter/material.dart';
import 'package:thingo/utils/app_color.dart';


class CustomTextButton extends StatefulWidget {
  final void Function() onPressed;
  final String btnTxt;
  final bool enableBorder;

  const CustomTextButton({Key? key, required this.onPressed, required this.btnTxt, this.enableBorder = true}) : super(key: key);

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(AppColor.primaryColor.withOpacity(0.3)),
        textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        )),
        side: MaterialStateProperty.all<BorderSide>(!widget.enableBorder ? BorderSide.none : const BorderSide(
          color: AppColor.primaryColor,
          width: 2,
        )),
      ),
      child: Text(
        widget.btnTxt,
        style: const TextStyle(
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}

import 'package:explore_city/utils/constant.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

//custom textfield

class CustomTextFormField extends StatefulWidget {
  final String? hintText;

  final Color? borderColor;

  dynamic validator;
  TextEditingController? controller;
  VoidCallback? onTap;
  TextStyle? hintTextStyle;
  int? maxLines;

  void Function(String)? onChange;

  CustomTextFormField(
      {Key? key,
      this.hintText,
      this.maxLines,
      this.validator,
      this.controller,
      this.onTap,
      this.borderColor,
      this.onChange,
      this.hintTextStyle})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autocorrect: false,
        style: Dosis.kTextStyleNormal,
        onTap: widget.onTap,
        controller: widget.controller,
        validator: widget.validator,
        cursorColor: primarycolor,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
                color: widget.borderColor ?? Colors.grey, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.grey,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: widget.hintText,
          hintStyle: widget.hintTextStyle,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}

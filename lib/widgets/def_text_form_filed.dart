import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefTextFormFiled extends StatelessWidget {
  final TextEditingController? textEditingController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool? password ;
  final TextInputType? keyboardType;
  final  TextInputAction? textInputAction;
  final  bool readOnly;
  final  bool autofocus ;
  final  String? hintText;
  final   Function(String)? onSubmitted;
  final   Function(String)? onChanged;
  final   EdgeInsets? contentPadding;
  final List<TextInputFormatter>? listTextInputFormatter;
  final int? maxLength;
  const DefTextFormFiled({Key? key, this.textEditingController,this.autofocus= false, this.prefixIcon,this.password= false, this.suffixIcon,this.readOnly= false, this.labelText, this.validator, this.keyboardType, this.textInputAction, this.hintText, this.onSubmitted, this.onChanged, this.contentPadding, this.listTextInputFormatter, this.maxLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: listTextInputFormatter,
      autofocus: autofocus,
      style: const TextStyle(fontWeight: FontWeight.bold),
      controller: textEditingController,
      maxLength: maxLength,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
      ),
      validator: validator,
      obscureText: password!,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    );
  }
}

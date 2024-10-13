import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final Icon? icon;
  final String? hint;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? errorMessage;
  final double? inputWidth;


  const CustomInput({
    super.key, 
    this.icon, 
    this.hint, 
    this.labelText, 
    this.keyboardType, 
    this.errorMessage,
    this.inputWidth,

    });

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (inputWidth != null) ? inputWidth : 200  , // Cambia este valor al ancho deseado
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          label: labelText != null ? Text(labelText!) : null,
        ),
      ),
    );
  }
}

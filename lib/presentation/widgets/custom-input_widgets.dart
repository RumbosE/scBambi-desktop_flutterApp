import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {

  final Icon? icon;
  final String? hint;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? errorMessage;
  final double? inputWidth;
  final Function(String)? onChanged;
  final String? initialState;
  final bool isRequired;


  const CustomInput({
    super.key, 
    this.icon, 
    this.hint, 
    this.labelText, 
    this.keyboardType, 
    this.errorMessage,
    this.inputWidth, 
    this.onChanged,
    this.initialState,
    this.isRequired = false
    });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialState);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (widget.inputWidth != null) ? widget.inputWidth : 200  ,
      child: TextFormField(
        controller: _controller,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w300),
          prefixIcon: widget.icon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          label: widget.labelText != null ? Text(widget.labelText!) : null,
        ),
      ),
    );
  }
}

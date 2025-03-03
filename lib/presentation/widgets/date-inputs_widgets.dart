import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DateInput extends StatefulWidget {
  final Function(DateTime) onChanged;
  final String label;
  final DateTime? initialValue;
  final double? width;
  final String? errorMessage;
  final bool clearInput;


  const DateInput({super.key, required this.onChanged, required this.label, this.initialValue, this.width, this.errorMessage, this.clearInput = false});

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue != null ? _formatDate(widget.initialValue!) : '',
    );
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: widget.width ?? 150,
      height: 40,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(fontSize: 12, color: colors.primary),
          filled: true,
          prefixIcon: const Icon(Icons.calendar_today),
          errorText: widget.errorMessage,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors.primary),
          ),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialValue ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
      widget.onChanged(picked);

      if (widget.clearInput) {
        _controller.clear();
      }
    }
  }
}
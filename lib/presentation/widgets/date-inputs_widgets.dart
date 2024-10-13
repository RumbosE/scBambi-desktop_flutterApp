import 'package:flutter/material.dart';

class DateInput extends StatelessWidget {

  final TextEditingController dateController;
  final Function setState;
  final String label;
  
  const DateInput({
    super.key,
    required this.dateController,
    required this.setState,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SizedBox(
            width: 150,
            height: 40,
            child: TextField(
              decoration:  InputDecoration(
                labelText: label,
                labelStyle: TextStyle(fontSize: 12, color: colors.primary),
                filled: true,
                prefixIcon: const Icon(Icons.calendar_today),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.primary),
                ),
              ),
              readOnly: true,
              controller: dateController,
              onTap: () => _selectDate(context),
            ),
          );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
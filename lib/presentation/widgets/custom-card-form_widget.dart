import 'package:flutter/material.dart';

class CustomCardForm extends StatelessWidget {

  final Widget child;
  const CustomCardForm({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.00),
                  child: SingleChildScrollView(
                    child: child
                  )))));
  }
}
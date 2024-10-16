import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class FormChildScreen extends StatelessWidget {
  
  static const String name = 'form_child_screen';
  const FormChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form to Add'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: Colors.white,
            onPressed: () {
              context.pop();
            },
          ),
      ),
      body: const SingleChildScrollView(),
    );
  }
}
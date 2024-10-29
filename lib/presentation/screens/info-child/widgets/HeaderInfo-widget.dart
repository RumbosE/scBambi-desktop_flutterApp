import 'package:flutter/material.dart';

class HeaderInfo extends StatelessWidget {

  final String title;
  const HeaderInfo({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Divider(
          color: Colors.black45,
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}

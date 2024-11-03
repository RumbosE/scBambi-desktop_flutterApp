import 'package:flutter/material.dart';

class ItemInfoChild extends StatelessWidget {
  final String title;
  final String? value;

  const ItemInfoChild({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.primaryFixed,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Text('$title: ',
              style: const TextStyle(
                  color: Colors.black45,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0)),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
            value ?? '--no-tiene--',
            style: const TextStyle(fontSize: 16.0),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        )
      ],
    );
  }
}

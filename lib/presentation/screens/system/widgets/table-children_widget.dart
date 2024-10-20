import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class TableChild extends StatelessWidget {
  const TableChild({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;


    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              TableCell(
                  child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text('Nro - Expediente', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              const TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Nombre'))),
              const TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Fecha de Ingreso'))),
              const TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Fecha de Egreso'))),
            ],
          ),
          TableRow(
            children: [
              GestureDetector(
                onDoubleTap: () => context.push('/system/info'),
                child: TableCell(
                  
                  child: Container(
                    color: const Color.fromARGB(255, 107, 206, 110),
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Row 1, Col 2'),
                  ),
                ),
              ),
              const TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 1, Col 2'))),
              const TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 1, Col 3'))),
              const TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 1, Col 4'))),
            ],
          ),
          const TableRow(
            children: [
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 2, Col 1'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 2, Col 2'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 2, Col 3'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 2, Col 4'))),
            ],
          ),
        ],
      ),
    );
  }
}

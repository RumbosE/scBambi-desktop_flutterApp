import 'package:flutter/material.dart';


class TableChild extends StatelessWidget {
  
  const TableChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Table(
        border: TableBorder.all(),
        children: const [
          TableRow(
            children: [
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Nro - Expediente'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Nombre'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Fecha de Ingreso')
                    )
                  ),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Fecha de Egreso')
                    )
                  ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 1, Col 1'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 1, Col 2'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 1, Col 3'))),
                      TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Row 1, Col 4'))),
            ],
          ),
          TableRow(
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

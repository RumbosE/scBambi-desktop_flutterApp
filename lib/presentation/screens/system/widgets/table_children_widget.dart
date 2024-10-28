import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/injector.dart';

import 'package:sc_flutter_app/presentation/blocs/children/child_bloc_bloc.dart';

class TableChildren extends StatelessWidget {
  const TableChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChildrenBlocBloc>(),
      child: const _TableChildren(),
    );
  }
}

class _TableChildren extends StatefulWidget {
  const _TableChildren();

  @override
  State<_TableChildren> createState() => _TableChildrenState();
}

class _TableChildrenState extends State<_TableChildren> {
  @override
  void initState() {
    super.initState();

    context.read<ChildrenBlocBloc>().loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<ChildrenBlocBloc, ChildrenBlocState>(
            builder: (context, state) {
          if (state.status == ChildrenStatus.loading &&
              state.children.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ChildrenStatus.error) {
            return const Center(
              child: Text('Algo inesperado paso'),
            );
          }

          if (state.children.isEmpty) {
            return const Center(
              child: Text('Esto esta vacio compa'),
            );
          }

          return Table(
            border: TableBorder.all(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0) )),
            children: [
              TableRow(children: [
                TableCell(
                    child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Nro - Expediente',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))),
                TableCell(
                    child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Nombre Completo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))),
                TableCell(
                    child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Fecha Ingreso',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))),
                TableCell(
                    child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Acciones',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))),
              ]),
              ...state.children.map((child) => TableRow(
                children: [
                  TableCell(
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(child.id),
                      )
                  ),
                  TableCell(
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${child.name!} ${child.lastName!}"),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(child.history!.entryDate!),
                      )
                  ),
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton.outlined(
                              onPressed: (){
                                context.push('/system/info');
                              },
                              mouseCursor: MouseCursor.defer,
                              icon: const Icon(Icons.remove_red_eye_rounded),
                            ),
                            IconButton.outlined(
                              onPressed: (){ },
                              color: Colors.lightBlueAccent,
                              mouseCursor: MouseCursor.defer,
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton.filled(
                              color: Colors.redAccent,
                              onPressed: (){ },
                              mouseCursor: MouseCursor.defer,
                              icon: const Icon(Icons.delete),
                            ),

                          ]),
                  ))
                ]
              )).toList()
            ],
          );
        }),
      ),
    );
  }
}

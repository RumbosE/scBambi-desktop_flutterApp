import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';
import 'package:sc_flutter_app/injector.dart';

import 'package:sc_flutter_app/presentation/blocs/children/child_bloc_bloc.dart';
import 'package:sc_flutter_app/presentation/blocs/delete-child/bloc/delete_child_bloc.dart';

class TableChildren extends StatelessWidget {
  const TableChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TableChildrenView();
  }
}

class _TableChildrenView extends StatelessWidget {
  const _TableChildrenView();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChildrenBlocBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<DeleteChildBloc>(),
        ),
      ],
      child: Builder(
        builder: (context) => MultiBlocListener(
          listeners: [
            BlocListener<ChildrenBlocBloc, ChildrenBlocState>(
              listener: (context, state) {
                if (state.status == ChildrenStatus.error) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Algo inesperado paso, verifica tu conexión a internet'),
                      ),
                    );
                }
              },
            ),
            BlocListener<DeleteChildBloc, DeleteChildState>(
              listener: (context, state) {
                if (state.status == DeleteStatus.error && !state.snackBarShown) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text('Algo inesperado paso: //${state.error}'),
                      ),
                    );
                  context.read<DeleteChildBloc>().add(SnackBarShown());
                }
                if (state.status == DeleteStatus.success && state.snackBarShown == false) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Elemento eliminado con éxito'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  context.read<DeleteChildBloc>().add(SnackBarShown());
                }
              },
            ),
          ],
          child: Center(
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
        
                if (state.children.isEmpty && state.page != 0) {
                  return Center(
                      child: Column(
                    children: [
                      buttonsPag(context.read<ChildrenBlocBloc>()),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text('Nada en esta pagina, vuelve a la anterior')
                    ],
                  ));
                }
        
                if (state.children.isEmpty ||
                    state.status == ChildrenStatus.initial) {
                  return const Center(
                    child: Text('Nada encontrado aun'),
                  );
                }
        
                return Column(
                  children: <Widget>[
                    buttonsPag(context.read<ChildrenBlocBloc>()),
                    Table(
                      border: TableBorder.all(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0))),
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
                                  child: const Text('Nombres',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                          TableCell(
                              child: Container(
                                  color: Colors.green,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text('Apellidos',
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
                        ...state.children.map((child) => TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: child.foundationId != null
                                    ? Text(child.foundationId!.toUpperCase())
                                    : const Text('No registrado'),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: child.name != null
                                    ? Text(child.name!.toLowerCase())
                                    : const Text('No registrado'),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: child.lastName != null
                                    ? Text(child.lastName!.toLowerCase())
                                    : const Text('No registrado'),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () => context.push('/system/info/${child.id}'),
                                        icon: const Icon(
                                            Icons.remove_red_eye_rounded),
                                      ),
                                      IconButton(
                                        onPressed: () => context.push('/system/edit/${child.id}'),
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _showDeleteDialog(
                                            child,
                                            context,
                                            context.read<DeleteChildBloc>(),
                                            context.read<ChildrenBlocBloc>()
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ]),
                              ))
                            ]))
                      ],
                    ),
                    buttonsPag(context.read<ChildrenBlocBloc>()),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(Child child, BuildContext context, DeleteChildBloc bloc, ChildrenBlocBloc children) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content:
              const Text('¿Estás seguro de que deseas eliminar este registro?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (child.id != null) {
                  bloc.add(DeleteChildEvent(id: child.id!, bloc: children));
                }
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  Widget buttonsPag(ChildrenBlocBloc childrenBloc) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16.00),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: childrenBloc.state.page == 0
                ? null
                : () => childrenBloc.setPage(childrenBloc.state.page - 1),
            child: const Text('Anterior'),
          ),
          const SizedBox(width: 10),
          Text('Página ${childrenBloc.state.page + 1}'),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: childrenBloc.state.children.isEmpty
                ? null
                : () => childrenBloc.setPage(childrenBloc.state.page + 1),
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }
}

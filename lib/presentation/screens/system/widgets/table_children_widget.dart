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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocBuilder<ChildrenBlocBloc, ChildrenBlocState>(
            
        builder: (context, state) {

            if (state.status == ChildrenStatus.loading && state.children.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ChildrenStatus.error) {
              return const Center(
                child: Text('Algo inesperado paso'),
              );
            }

            if (state.children.isEmpty){
              return const Center(
                child: Text('Esto esta vacio compa'),
              );
            }

          return DataTable(
            columns: const [
                      DataColumn(label: Text('Nro Expediente')),
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Fecha Ingreso')),
                    ],
            rows: List<DataRow>.generate(
                state.children.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(state.children[index].foundationId != null ? state.children[index].foundationId! : '1' )),
                    DataCell(Text(state.children[index].name!)),
                    DataCell(Text(state.children[index].history!.entryDate!))
                  ])
            )
          );
      },
      ),
    );
  }
}

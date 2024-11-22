import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';
import 'package:sc_flutter_app/injector.dart';
import 'package:sc_flutter_app/presentation/blocs/child-details/child_bloc.dart';
import 'package:sc_flutter_app/presentation/blocs/search-filter/search_filter_cubit.dart';
import 'widgets/info_child_widgets.dart';

class InfoChildScreen extends StatelessWidget {
  static const String name = 'info_child_screen';

  final String idChild;

  const InfoChildScreen({super.key, required this.idChild});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChildBloc>()..loadChildById(idChild),
      child: const _ChildView(),
    );
  }
}

class _ChildView extends StatelessWidget {
  const _ChildView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildBloc, ChildState>(
      builder: (context, state) {
        if (state.status == ChildDetailsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ChildDetailsStatus.error) {
          return Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 50,),
                const Text('Error al cargar la información'),
                Text('Info error -> ${state.errors}', style: const TextStyle(fontSize: 10, color: Colors.redAccent),),
                const SizedBox(height: 8,),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<SearchFilterCubit>().reset();
                    context.go('/system');
                  },
                  label: const Text('Volver atras'),
                  icon: const Icon(Icons.arrow_back_rounded)
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {
                context.read<SearchFilterCubit>().reset();
                context.go('/system');},
            ),
            title: const Text('Información',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w400)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: _ChildDetailsView(state.child),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () =>context.go('/system/edit/${state.child.id}'),
            icon: const Icon(Icons.edit),
            label: const Text('Editar'),
          ),
        );
      },
    );
  }
}

class _ChildDetailsView extends StatelessWidget {
  final Child child;

  const _ChildDetailsView(this.child);

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderInfo(title: 'Datos Personales'),
                      ItemInfoChild(title: 'Nombre', value: child.name),
                      const SizedBox(height: 8,),
                      ItemInfoChild(title: 'Apellido', value: child.lastName),
                      const SizedBox(height: 8,),
                      ItemInfoChild(title: 'Identificacion', value: child.personalId),
                      const SizedBox(height: 8,),
                      ItemInfoChild(title: 'Fecha de Nacimiento', value: child.birthCertificate),


                      const SizedBox(height: 24,),
                      const HeaderInfo(title: 'Representantes o Responsables'),
                      //ItemInfoChild(title: 'Nombre(s)', value: child.responsible?.names?.toString()),
                      _ListItemWidget(title: 'Nombre(s)', items: child.responsible.names ?? []),
                      const SizedBox(height: 8,),
                      //ItemInfoChild(title: 'Identificacion(es)', value: child.responsible?.docsId?.toString()),
                      _ListItemWidget(title: 'Identificacion(es)', items: child.responsible.docsId ?? []),
                      const SizedBox(height: 8,),
                      //ItemInfoChild(title: 'Contacto(s)', value: child.responsible?.contactNro?.toString()),
                      _ListItemWidget(title: 'Contacto(s)', items: child.responsible.contactNro ?? []),


                      const SizedBox(height: 24,),
                      const HeaderInfo(title: 'Datos Fundacionales'),
                      ItemInfoChild(title: 'Nro. Expediente Interno', value: child.foundationId),
                      const SizedBox(height: 8,),
                      ItemInfoChild(title: 'Nro. Expediente Tribunal', value: child.history.courtId),
                      const SizedBox(height: 8,),
                      ItemInfoChild(title: 'Fecha de Ingreso', value: child.history.entryDate.toString()),
                      const SizedBox(height: 16,),
                      _ListItemWidget (title: 'Motivo(s) Ingreso', items: child.history.entryReason),
                      const SizedBox(height: 8,),
                      ItemInfoChild(title: 'Fecha de Salida', value: child.history.departureDate.toString()),
                      const SizedBox(height: 8,),
                      ItemInfoChild(title: 'Motivo Salida', value: child.history.departureReason),
                      const SizedBox(height: 8,),
                      Container(
                        decoration: BoxDecoration(
                          color: colors.primaryFixed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Organización Judicial: ${child.foundationId?? ' '}',
                            style: const TextStyle(
                                color: Colors.black45,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                      ),
                      Text(
                        child.history.organization ?? '--no-tiene--',
                        style: const TextStyle(fontSize: 16.0),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      )

                    ],
                  ),
                )
              ),
            )));
  }
}

class _ListItemWidget extends StatelessWidget {
  final String title;
  final List<String> items;

  const _ListItemWidget({required this.title, required this.items});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 8.0),
        if (items.isEmpty) const Text('No hay registrados') else ...items.map((r) => _ItemListWidget(item :r)),
      ],
    );
  }
}

class _ItemListWidget extends StatelessWidget {
  final String item;
  const _ItemListWidget({ required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, color: Colors.green, size: 8,),
        const SizedBox(width: 8.0),
        Text(
          item,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}



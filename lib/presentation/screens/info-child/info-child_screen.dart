import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';
import 'package:sc_flutter_app/injector.dart';
import 'package:sc_flutter_app/presentation/blocs/child-details/child_bloc.dart';
import 'widgets/info_child_widgets.dart';

class InfoChildScreen extends StatelessWidget {
  static const String name = 'info_child_screen';

  final String idChild;

  const InfoChildScreen({super.key, required this.idChild});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChildBloc>()..loadChildById(idChild),
      child: const _ChildView(),
    );
  }
}

class _ChildView extends StatelessWidget {
  const _ChildView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildBloc, ChildState>(
      builder: (context, state) {
        if (state.child.id.isEmpty ||
            state.status == ChildDetailsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ChildDetailsStatus.error) {
          return const Center(
            child: Text('Blog Not found'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text('Información',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w400)),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
          body: _ChildDetailsView(state.child),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
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
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderInfo(title: 'Datos Personales'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemInfoChild(
                      title: 'Nombre',
                      value: child.name!,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ItemInfoChild(
                      title: 'Apellido',
                      value: child.lastName!,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemInfoChild(
                      title: 'Identification',
                      value: child.personalId!,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ItemInfoChild(
                      title: 'Fecha de Nacimiento',
                      value: child.birthDate!,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            
            const HeaderInfo(title: 'Representantes o Responsables'),

            ItemInfoChild(title: 'Nombre (s)', value: child.responsible?.names.toString(),)
          ],
        ),
      ),
    );
  }
}


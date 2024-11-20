import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/injector.dart';
import 'package:sc_flutter_app/presentation/blocs/search-filter/search_filter_cubit.dart';
import 'package:sc_flutter_app/presentation/screens/system/widgets/system_widgets.dart';
import 'package:sc_flutter_app/presentation/widgets/custom-input_widgets.dart';
import 'package:sc_flutter_app/presentation/widgets/date-inputs_widgets.dart';

class SystemScreen extends StatelessWidget {
  static const String name = 'system_screen';

  const SystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: Colors.white,
            onPressed: () {
              context.pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            BlocProvider(
              create: (context) => getIt<SearchFilterCubit>(),
              child: _FiltersContainer(),
            ),
            const SizedBox(height: 20),

            const TableChildren(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Agregar al sistema'),
          onPressed: () {
            context.push('/system/add');
          }),
    );
  }
}

class _FiltersContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final filterCubit = context.watch<SearchFilterCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text('Busqueda por filtros', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))),
      
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomInput(
                    icon: const Icon(Icons.boy),
                    hint: 'Nombre Apellido o Nro Expediente',
                    labelText: 'Buscar por Nombre, Apellido o Nro Expediente',
                    keyboardType: TextInputType.text,
                    inputWidth: MediaQuery.of(context).size.width * 0.5,
                    onChanged: filterCubit.setFilterParam,
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(onPressed: filterCubit.onSubmitted, label: const Text('Buscar'), icon: const Icon(Icons.search)),
                ],
              ),
            ),
        ),
      ],
    );
  }
}

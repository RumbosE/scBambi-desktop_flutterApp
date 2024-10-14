import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/presentation/blocs/search-filter/search_filter_cubit.dart';
import 'package:sc_flutter_app/presentation/screens/system/widgets/system_widgets.dart';
import 'package:sc_flutter_app/presentation/widgets/custom-input_widgets.dart';
import 'package:sc_flutter_app/presentation/widgets/date-inputs_widgets.dart';

class SystemScreen extends StatefulWidget {
  static const String name = 'system_screen';

  const SystemScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SystemScreenState createState() => _SystemScreenState();
}

class _SystemScreenState extends State<SystemScreen> {

  int _currentPage = 1;

  void _previousPage() {
    setState(() {
      if (_currentPage > 1) {
        _currentPage--;
      }
    });
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
    });
  }

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
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  label: const Text('Agregar'),
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    context.push('/system/add');
                  }),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
        
            BlocProvider(
              create: (context) => SearchFilterCubit(),
              child: const _FiltersContainer(),
            ),
        
            const SizedBox(height: 20),
            const TableChild(),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _previousPage,
                  child: const Text('Anterior'),
                ),
                const SizedBox(width: 5),
                Text('Página $_currentPage'),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: const Text('Siguiente'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FiltersContainer extends StatelessWidget {

  const _FiltersContainer();

  @override
  Widget build(BuildContext context) {

    final filterCubit = context.watch<SearchFilterCubit>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Filtrar por:'),
            const SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Periodo de tiempo'),
                const SizedBox(width: 5), // Espacio reducido entre los botones
                DateInput(
                  initialValue: filterCubit.state.startDate,
                  onChanged: filterCubit.setStartDate,
                  label: 'Desde',
                ),
                const SizedBox(width: 5),
                DateInput(
                  initialValue: filterCubit.state.endDate,
                  onChanged: filterCubit.setEndDate,
                  label: 'Hasta',
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
                // ignore: avoid_print
                filterCubit.onSubmitted();
                print('Filtrar');
              },
              icon: const Icon(Icons.filter_list),
              label: const Text('Filtrar'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomInput(
                icon: const Icon(Icons.boy),
                hint: 'Buscar por nombre',
                labelText: 'Nombre',
                keyboardType: TextInputType.text,
                inputWidth: 400,
                onChanged: (value) => filterCubit.setName(value),
              ),
              CustomInput(
                icon: const Icon(Icons.menu_book_outlined),
                hint: 'Buscar por Numero de expediente',
                labelText: 'Nro - Expediente',
                keyboardType: TextInputType.text,
                inputWidth: 400,
                onChanged: (value) => filterCubit.setNroExp(value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

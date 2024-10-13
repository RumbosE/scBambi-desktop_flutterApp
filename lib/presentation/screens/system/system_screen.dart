import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/presentation/screens/system/widgets/system_widgets.dart';
import 'package:sc_flutter_app/presentation/widgets/custom-input_widgets.dart';
import 'package:sc_flutter_app/presentation/widgets/date-inputs_widgets.dart';

enum SearchState { ingresados, egresados }

class SystemScreen extends StatefulWidget {
  static const String name = 'system_screen';

  const SystemScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SystemScreenState createState() => _SystemScreenState();
}

class _SystemScreenState extends State<SystemScreen> {
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController(text: DateTime.now().toString().split(" ")[0]);

  int _selectedIndex = 0;
  int _currentPage = 1;

  @override
  void dispose() {
    _dateStartController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

    final colors = Theme.of(context).colorScheme;

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
              }
            ),
          )
        ]
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Filtrar por:'),
              const SizedBox(width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Periodo de tiempo'),
                  
                  const SizedBox(
                      width: 5), // Espacio reducido entre los botones
                  DateInput(
                    dateController: _dateStartController,
                    setState: setState,
                    label: 'Desde',
                  ),
                  const SizedBox(width: 5),
                  DateInput(
                    dateController: _dateEndController,
                    setState: setState,
                    label: 'Hasta',
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // ignore: avoid_print
                  print('Filtrar');
                },
                icon: const Icon(Icons.filter_list),
                label: const Text('Filtrar'),
                
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomInput(
                  icon: Icon(Icons.boy),
                  hint: 'Buscar por nombre',
                  labelText: 'Nombre',
                  keyboardType: TextInputType.text,
                  inputWidth: 400,
                ),
                CustomInput(
                  icon: Icon(Icons.menu_book_outlined),
                  hint: 'Buscar por Numero de expediente',
                  labelText: 'Nro - Expediente',
                  keyboardType: TextInputType.number,
                  inputWidth: 400,
                ),
              ],
            ),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

enum Sexo { masculino, femenino }

class SystemScreen extends StatefulWidget {
  static const String name = 'system_screen';

  const SystemScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SystemScreenState createState() => _SystemScreenState();
}

class _SystemScreenState extends State<SystemScreen> {
  final TextEditingController _yearController = TextEditingController();
  int _selectedIndex = 0;
  int _currentPage = 1;
  Sexo? _selectedSexo;

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onSexoSelected(Sexo sexo) {
    setState(() {
      _selectedSexo = sexo;
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
      ),

      // ignore: prefer_const_constructors
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Filtrar por:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Sexo:'),
                  const SizedBox(
                      width: 5), // Espacio reducido entre los botones

                  ElevatedButton(
                    onPressed: () {
                      // Acción del botón 1
                      onSexoSelected(Sexo.masculino);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _selectedSexo == Sexo.masculino ? Colors.green : null,
                      padding: const EdgeInsets.all(8.0),
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      foregroundColor: _selectedSexo == Sexo.masculino
                          ? Colors.white
                          : null,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                    child: const Text('M'),
                  ),
                  const SizedBox(
                      width: 5), // Espacio reducido entre los botones
                  ElevatedButton(
                    onPressed: () {
                      // Acción del botón 2
                      onSexoSelected(Sexo.femenino);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _selectedSexo == Sexo.femenino ? Colors.green : null,
                      padding: const EdgeInsets.all(8.0),
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      foregroundColor: _selectedSexo == Sexo.femenino
                          ? Colors.white
                          : null,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                    child: const Text('F'),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Año de nacimiento:'),
                  const SizedBox(
                      width: 5), // Espacio reducido entre los botones

                  SizedBox(
                    width: 100,
                    height: 40,
                    child: TextField(
                      maxLength: 4,
                      controller: _yearController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Año',
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Permitir solo números
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_yearController.text.length < 4 &&
                      _yearController.text.isNotEmpty) {
                    // Mostrar un mensaje de error o realizar alguna acción
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('El año debe tener al menos 4 caracteres')),
                    );
                  } else {
                    // Acción cuando la longitud es válida
                  }
                },
                child: const Text('Filtrar'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por Nro Expediente o nombre...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const _TableChild(),
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

class _TableChild extends StatelessWidget {
  
  const _TableChild();

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
                      child: Text('Fecha de Nacimiento'))),
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
            ],
          ),
        ],
      ),
    );
  }
}

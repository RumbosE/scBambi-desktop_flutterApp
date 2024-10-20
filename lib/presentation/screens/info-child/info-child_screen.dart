import 'package:flutter/material.dart';

class InfoChildScreen extends StatelessWidget {

  static const String name = 'info_child_screen';
  const InfoChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            
            icon: const Icon( Icons.arrow_back_rounded, color: Colors.white ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        title: const Text('Pagina de Información'),
        actions: [
          IconButton(onPressed: (){ }, icon: const Icon( Icons.more_vert, color: Colors.white, )),
        ],
      ),

      body: const Center(
        child: Text('Info Child Screen'),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () { },
        icon: const Icon(Icons.edit), 
        label: const Text('Editar'),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:bambi_socio_legal_scapp/presentation/screens/home/widgets/main_drawer_widget.dart';

class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fundacion Hogar Bambi'),
        iconTheme: const IconThemeData(
          color: Colors.white, // Cambia este color al que desees
        ),
        ),

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
                Text('Sistema de Gestion:\n Direccion Administrativa Socio-legal',
                    style: TextStyle(fontSize:36, color: colors.primary, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20, width: 20,),
                
                Image.asset('assets/images/HBV_logo.png', width: 200, height: 200),
            ]
        ),
      ),
      drawer: const MainDrawer()
    );
  }
}


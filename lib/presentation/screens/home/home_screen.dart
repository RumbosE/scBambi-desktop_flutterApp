import 'package:flutter/material.dart';
import 'package:sc_flutter_app/presentation/widgets/main_drawer_widget.dart';

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
          color: Colors.white
        ),
        actions: const [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: null,
          )
        ],
      ),
      body: Center(
        child: Text('Sistema de Gestion:\n Direccion Administrativa Socio-legal',
                  style: TextStyle(fontSize:36, color: colors.primary, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,),
      ),

      drawer: const MainDrawer()
    );
  }
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class FormChildScreen extends StatefulWidget {
  
  static const String name = 'form_child_screen';
  const FormChildScreen({super.key});

  @override
  State<FormChildScreen> createState() => _FormChildScreenState();
}

class _FormChildScreenState extends State<FormChildScreen> {
  int currentStep =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: Colors.white,
            onPressed: () {
              context.pop();
            },
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stepper(
          type: StepperType.horizontal,
          steps:getStepts(),
          currentStep: currentStep,
          onStepContinue: (){
            final isLastStep = currentStep == getStepts().length-1;
            if (isLastStep){
              print('Form Completed');
            }else{
              setState(() => currentStep +=1);
            }
          },
          onStepCancel: currentStep == 0 ? null : (){setState(() => currentStep-=1);},
        ),
      ),
    );
  }

  List<Step> getStepts() => [
    Step(isActive: currentStep >=0 ,title: const Text('Datos Personales'), content: Container()),
    Step(isActive: currentStep>=1 ,title: const Text('Representantes'), content: Container()),
    Step(isActive: currentStep>=2 ,title: const Text('Organización'), content: Container()),
    Step(isActive: currentStep>=3 ,title: const Text('Completado'), content: Container()),

  ];
}
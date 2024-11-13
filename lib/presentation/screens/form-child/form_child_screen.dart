import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/presentation/blocs/child-form/child_form_bloc.dart';
import 'package:sc_flutter_app/presentation/screens/info-child/widgets/HeaderInfo-widget.dart';
import 'package:sc_flutter_app/presentation/widgets/custom-input_widgets.dart';
import 'package:sc_flutter_app/presentation/widgets/date-inputs_widgets.dart';

class FormChildScreen extends StatefulWidget {
  static const String name = 'form_child_screen';

  const FormChildScreen({super.key});

  @override
  State<FormChildScreen> createState() => _FormChildScreenState();
}

class _FormChildScreenState extends State<FormChildScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildFormCubit(),
      child: Scaffold(
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
          child: BlocListener<ChildFormCubit, ChildFormState>(
              listener: (context, state) {
              if (state.status == FormStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errors ?? 'Error en los datos personales'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<ChildFormCubit, ChildFormState>(
              builder: (context, state) {
                final formCubit = context.watch<ChildFormCubit>();

                return Stepper(
                    type: StepperType.horizontal,
                    currentStep: currentStep,
                    onStepCancel: currentStep == 0
                        ? null
                        : () {
                            setState(() => currentStep -= 1);
                          },
                    onStepContinue: () {
                      final isLastStep =
                          currentStep == getSteps(formCubit).length - 1;

                      if (isLastStep) {
                        print('Completed');
                      }
                      if (currentStep == 0) {
                        final c= context.read<ChildFormCubit>();
                        c.validatePersonalData();
                        if(c.state.status == FormStatus.error){
                          return;
                        }
                      }
                      setState(() => currentStep += 1);
                    },
                    steps: getSteps(formCubit));
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps(ChildFormCubit fcubit) => [
        Step(
            isActive: currentStep >= 0,
            title: const Text('Datos Personales'),
            content: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16.00),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                const HeaderInfo(title: 'Datos Personales'),
                                CustomInput(
                                  labelText: 'Nombres *',
                                  keyboardType: TextInputType.text,
                                  initialState: fcubit.state.child.name,
                                  hint: '*Campo requerido*',
                                  isRequired: true,
                                  onChanged:fcubit.setName,
                                  inputWidth: double.infinity,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomInput(
                                  labelText: 'Apellidos *',
                                  hint: '*Campo requerido*',
                                  initialState: fcubit.state.child.lastName,
                                  onChanged: fcubit.setLastName,
                                  keyboardType: TextInputType.text,
                                  inputWidth: double.infinity,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomInput(
                                  labelText: 'Identificación',
                                  keyboardType: TextInputType.text,
                                  onChanged: fcubit.setIdentification,
                                  inputWidth: double.infinity,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                DateInput(
                                  onChanged: fcubit.setBirthDate,
                                  label: 'Fecha de Nacimiento',
                                  width: double.infinity,
                                  initialValue: fcubit.state.child.birthDate != null
                                      ? DateTime.parse(fcubit.state.child.birthDate!)
                                      : null,
                                )
                              ],
                            ),
                          ),
                        ))))),
        Step(
            isActive: currentStep >= 1,
            title: const Text('Representantes'),
            content: Container()),
        Step(
            isActive: currentStep >= 2,
            title: const Text('Organización'),
            content: Container()),
        Step(
            isActive: currentStep >= 3,
            title: const Text('Completado'),
            content: Container()),
      ];
}

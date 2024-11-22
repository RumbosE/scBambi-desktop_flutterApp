import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/injector.dart';
import 'package:sc_flutter_app/presentation/blocs/child-form/child_form_bloc.dart';
import 'package:sc_flutter_app/presentation/blocs/search-filter/search_filter_cubit.dart';
import 'package:sc_flutter_app/presentation/screens/info-child/widgets/HeaderInfo-widget.dart';
import 'package:sc_flutter_app/presentation/widgets/widgets.dart';

class FormChildScreen extends StatefulWidget {
  static const String name = 'form_child_screen';

  final String? id;

  const FormChildScreen({super.key, this.id});

  @override
  State<FormChildScreen> createState() => _FormChildScreenState();
}

class _FormChildScreenState extends State<FormChildScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChildFormCubit>()..init(widget.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.id != null ? 'Formulario para Editar' : 'Formulario para Ingresar'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: Colors.white,
            onPressed: () {
              context.read<SearchFilterCubit>().reset();
              context.go('/system');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<ChildFormCubit, ChildFormState>(
            listener: (context, state) {
              if (state.status == FormStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Guardado con exito'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
              if (state.status == FormStatus.error){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.errors}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state.status == FormStatus.submitting) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Guardando...'),
                    backgroundColor: Colors.blue,
                  ),
                );
              }
            },
            child: BlocBuilder<ChildFormCubit, ChildFormState>(
              builder: (context, state) {
                if(state.status == FormStatus.loading){
                  return const Center(child: CircularProgressIndicator());
                }

              final formCubit = context.watch<ChildFormCubit>();

                return Stepper(
                    type: StepperType.horizontal,
                    currentStep: currentStep,
                    onStepCancel: currentStep == 0
                        ? null
                        : () {
                            setState(() => currentStep -= 1);
                          },
                    onStepContinue: () async {
                      final isLastStep = currentStep == getSteps(formCubit).length - 1;
                      
                      if (currentStep == 0) {
                        final c = context.read<ChildFormCubit>();
                        c.validatePersonalData();
                        if (c.state.status == FormStatus.error) {
                          return;
                        }
                      }
                      
                      if(currentStep == 2){
                        final c = context.read<ChildFormCubit>();
                        c.validateFoundationData();
                        if (c.state.status == FormStatus.error) {
                          return;
                        }
                      }

                      if (isLastStep) {
                        await formCubit.onSubmitted();
                        if (formCubit.state.status == FormStatus.success) {
                          // widget.id != null ? context.go('/system/info/${widget.id}') : context.go('/system');
                          if(widget.id != null){
                            context.go('/system/info/${widget.id}');
                          }else{
                             context.read<SearchFilterCubit>().reset();
                            context.go('/system');
                          }
                        }
                        return;
                      }
                      setState(() => currentStep += 1);
                    },
                    controlsBuilder:(BuildContext context, ControlsDetails details) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (currentStep != 0)
                              ElevatedButton(
                                onPressed: details.onStepCancel,
                                child: const Text('Atras'),
                              ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: details.currentStep ==
                                      getSteps(formCubit).length - 1
                                  ? const Text('Guardar')
                                  : const Text('Continuar'),
                            ),
                          ],
                        ),
                      );
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
            content: CustomCardForm(
              child: Column(
                children: <Widget>[
                  const HeaderInfo(title: 'Datos Personales'),
                  CustomInput(
                    labelText: 'Nombres *',
                    keyboardType: TextInputType.text,
                    initialState: fcubit.state.child.name,
                    hint: '*Campo requerido*',
                    errorMessage: (fcubit.state.child.name == null ||
                                fcubit.state.child.name!.isEmpty)
                              ? 'El nombre es requerido'
                              : null,
                    onChanged: fcubit.setName,
                    inputWidth: double.infinity,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomInput(
                    labelText: 'Apellidos *',
                    hint: '*Campo requerido*',
                    initialState: fcubit.state.child.lastName,
                    errorMessage:fcubit.state.child.lastName == null ||
                                fcubit.state.child.lastName!.isEmpty
                              ? 'El apellido es requerido'
                              : null,
                    onChanged: fcubit.setLastName,
                    keyboardType: TextInputType.text,
                    inputWidth: double.infinity,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomInput(
                    labelText: 'Identificación',
                    keyboardType: TextInputType.text,
                    initialState: fcubit.state.child.personalId,
                    onChanged: fcubit.setIdentification,
                    inputWidth: double.infinity,
                    errorMessage: (fcubit.state.child.personalId != null && (fcubit.state.child.personalId!.length > 1 && fcubit.state.child.personalId!.length < 8))
                              ? 'La identificacion no puede ser menor a 8 caracteres'
                              : null,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomInput(
                    labelText: 'Certificado de Nacimiento',
                    initialState: fcubit.state.child.birthCertificate,
                    keyboardType: TextInputType.text,
                    onChanged: fcubit.setBirthCertificate,
                    inputWidth: double.infinity,
                    errorMessage: (fcubit.state.child.birthCertificate != null && (fcubit.state.child.birthCertificate!.length < 5 && fcubit.state.child.birthCertificate!.length >1))
                              ? 'El certificado de nacimiento no puede ser menor a 5 caracteres'
                              : null,
                  ),
                ],
              ),
            )),
        Step(
            isActive: currentStep >= 1,
            title: const Text('Representantes'),
            content: CustomCardForm(
              child: Column(children: <Widget>[
                const HeaderInfo(title: 'Representantes o Responsables'),
                _CustomTextInputList(
                  hint: 'Nombre del responsable',
                  onAdded: fcubit.pushResponsibleName,
                  items: fcubit.state.child.responsible.names ?? [],
                  onDeleted: fcubit.popResponsibleName,
                ),
                const SizedBox(
                  height: 24,
                ),
                _CustomTextInputList(
                  hint: 'Documentos de Identidad',
                  onAdded: fcubit.pushResponsibleDoc,
                  items: fcubit.state.child.responsible.docsId ?? [],
                  onDeleted: fcubit.popResponsibleDoc,
                ),
                const SizedBox(
                  height: 24,
                ),
                _CustomTextInputList(
                  hint: 'Numeros de Contacto',
                  onAdded: fcubit.pushResponsibleContact,
                  items: fcubit.state.child.responsible.contactNro ?? [],
                  onDeleted: fcubit.popResponsibleContact,
                ),
              ]),
            )),
        Step(
            isActive: currentStep >= 2,
            title: const Text('Organización'),
            content: CustomCardForm(
                child: Column(
              children: <Widget>[
                const HeaderInfo(title: 'Historia en la Fundación'),
                const SizedBox(height: 8,),
                Flex(direction: Axis.horizontal, children: <Widget>[
                  Expanded(
                    child: CustomInput(
                      labelText: 'Nro. Expediente Interno *',
                      hint: '*Campo requerido*',
                      keyboardType: TextInputType.text,
                      onChanged: fcubit.setFoundationId,
                      inputWidth: double.infinity,
                      initialState: fcubit.state.child.foundationId,
                      errorMessage: (fcubit.state.child.foundationId == null ||
                                fcubit.state.child.foundationId!.isEmpty)
                              ? 'El Nro de Expediente interno es requerido'
                              : null,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomInput(
                      labelText: 'Nro. Expediente Tribunal *',
                      hint: '*Campo requerido*',
                      keyboardType: TextInputType.text,
                      onChanged: fcubit.setFoundationCorteId,
                      inputWidth: double.infinity,
                      initialState: fcubit.state.child.history.courtId,
                      errorMessage:(fcubit.state.child.history.courtId == null ||
                                fcubit.state.child.history.courtId!.isEmpty)
                              ? 'El Nro de Expediente tribunal es requerido'
                              : null,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 24,
                ),
                Flex(direction: Axis.horizontal, crossAxisAlignment: CrossAxisAlignment.start ,children: <Widget>[
                  Expanded(
                    child: _CustomInputDateList(
                      label: 'Fecha de Ingreso *',
                      items: fcubit.state.child.history.entryDate,
                      onAdded: fcubit.pushFoundationEntryDate,
                      onDeleted: fcubit.popFoundationEntryDate,
                      errorMessage: (fcubit.state.child.history.entryDate.isEmpty)
                              ? 'La fecha de ingreso es requerida'
                              : null,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: _CustomInputDateList(
                      label: 'Fecha de Egreso',
                      items: fcubit.state.child.history.departureDate,
                      onAdded: fcubit.pushFoundationDepartureDate,
                      onDeleted: fcubit.popFoundationDepartureDate,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 24,
                ),
                Flex(direction: Axis.horizontal, crossAxisAlignment: CrossAxisAlignment.start ,children: <Widget>[
                  Expanded(
                    child: _CustomTextInputList(
                      hint: 'Motivos de Ingreso *',
                      onAdded: fcubit.pushEntryReason,
                      items: fcubit.state.child.history.entryReason,
                      onDeleted: fcubit.popEntryReason,
                      errorMessage: (fcubit.state.child.history.entryReason.isEmpty)
                                ? 'Motivo de ingreso requerido'
                                : null,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomInput(
                      labelText: 'Motivo de Salida',
                      initialState: fcubit.state.child.history.departureReason,
                      keyboardType: TextInputType.text,
                      onChanged: fcubit.setFoundationDepartureReason,
                      inputWidth: double.infinity,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 24,
                ),
                CustomInput(
                  hint: 'Escribe sobre la organización judicial del niño',
                  labelText: 'Organización Judicial*',
                  keyboardType: TextInputType.text,
                  onChanged: fcubit.setFoundationOrganization,
                  maxLines: 3,
                  inputWidth: double.infinity,
                  initialState: fcubit.state.child.lastName,
                  errorMessage:(fcubit.state.child.history.organization == null ||
                              fcubit.state.child.history.organization!.isEmpty)
                            ? 'Una descripcion de la organizacion judicial es requerida'
                            : null,
                )
              ],
            ))),
        Step(
            isActive: currentStep >= 3,
            title: const Text('Listo para guardar'),
            content: CustomCardForm(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                const HeaderInfo(title: 'Datos ingresados'),
                const SizedBox(
                  height: 16,
                ),
                const Text('Datos Personales:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8,
                ),
                Text('Nombre: ${fcubit.state.child.name}'),
                const SizedBox(
                  height: 8,
                ),
                Text('Apellidos: ${fcubit.state.child.lastName}'),
                const SizedBox(
                  height: 8,
                ),
                Text('Certificado de Nacimiento: ${fcubit.state.child.birthCertificate}'),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    'Identificación: ${fcubit.state.child.personalId}'),
                const SizedBox(
                  height: 16,
                ),
                const Text('Representantes o Responsables:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8,
                ),
                const Text('Nombres',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(
                  height: 8,
                ),
                fcubit.state.child.responsible.names == null || fcubit.state.child.responsible.names!.isEmpty
                    ? const Text('No ingreso nombres')
                    : Column(
                        children: fcubit.state.child.responsible.names!
                            .map((e) => Text(e))
                            .toList(),
                      ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Documento de Identidad',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(
                  height: 8,
                ),
                fcubit.state.child.responsible.docsId == null || fcubit.state.child.responsible.docsId!.isEmpty
                    ? const Text('No ingreso documentos de identidad')
                    : Column(
                        children: fcubit.state.child.responsible.docsId!
                            .map((e) => Text(e))
                            .toList(),
                      ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Numero de Contacto',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(
                  height: 8,
                ),
                fcubit.state.child.responsible.contactNro == null || fcubit.state.child.responsible.contactNro!.isEmpty
                    ? const Text('No ingreso numeros de contacto')
                    : Column(
                        children: fcubit.state.child.responsible.contactNro!
                            .map((e) => Text(e))
                            .toList(),
                      ),
                const SizedBox(
                  height: 16,
                ),
                const Text('Datos Fundacion:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8,
                ),
                Text('Id Fundacion: ${fcubit.state.child.foundationId}'),
                const SizedBox(
                  height: 8,
                ),
                Text('Id Corte: ${fcubit.state.child.history.courtId}'),
                const SizedBox(
                  height: 8,
                ),
                Text('Fecha de Ingreso: ${fcubit.state.child.history.entryDate}'),
                const SizedBox(
                  height: 8,
                ),
                const Text('Motivos de Ingreso',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(
                  height: 8,
                ),
                fcubit.state.child.history.entryReason.isEmpty
                    ? const Text('No ingreso motivos')
                    : Column(
                        children: fcubit.state.child.history.entryReason
                            .map((e) => Text(e))
                            .toList(),
                      ),
                const SizedBox(
                  height: 8,
                ),
                Text('Fecha de Salida: ${fcubit.state.child.history.departureDate}'),
                const SizedBox(
                  height: 8,
                ),
                Text('Motivo de Salida: ${fcubit.state.child.history.departureReason}'),
                const SizedBox(
                  height: 8,
                ),
                Text('Organización Judicial: ${fcubit.state.child.history.organization}'),

              ]),
            )),
      ];
}

class _CustomInputDateList extends StatelessWidget {

  final String label;
  final Function(DateTime) onAdded;
  final Function(String) onDeleted;
  final List<String> items;
  final String? errorMessage;
  
  const _CustomInputDateList({required this.label, required this.onAdded, required this.onDeleted, required this.items, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        DateInput(
          onChanged: onAdded,
          label: label,
          width: double.infinity,
          errorMessage: errorMessage,
          clearInput: true
        ),
        const SizedBox(
          height: 16,
        ),
        ...List.generate(
            items.length,
            (index) => ListTile(
                  title: Text(items[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDeleted(items[index]),
                  ),
                )),
      ],
    );
  }
}

class _CustomTextInputList extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final String? hint;

  final Function(String) onAdded;
  final Function(String) onDeleted;
  final List<String> items;
  final String? errorMessage;

  _CustomTextInputList({
    required this.hint,
    required this.onAdded,
    required this.items,
    required this.onDeleted,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            errorText: errorMessage,
            suffixIcon: IconButton(
                onPressed: () {
                  if (_controller.value.text.isNotEmpty) {
                    onAdded(_controller.value.text);
                  }
                  _controller.clear();
                },
                icon: const Icon(Icons.add)),
            hintText: hint,
            hintStyle: const TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w300),
            border: UnderlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ...List.generate(
            items.length,
            (index) => ListTile(
                  title: Text(items[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDeleted(items[index]),
                  ),
                )),
      ],
    );
  }
}

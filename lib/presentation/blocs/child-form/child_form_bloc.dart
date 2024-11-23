import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bambi_socio_legal_scapp/domain/child/entities/child.dart';
import 'package:bambi_socio_legal_scapp/domain/child/repositories/child_repository.dart';
import 'package:intl/intl.dart';
part 'child_form_state.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}


final Child initChild = Child(responsible: Responsible(names: [],), history: FoundationHistory());

class ChildFormCubit extends Cubit<ChildFormState> {

  final IChildRepository repository;
  
  ChildFormCubit({required this.repository}): super(ChildFormState(child:initChild));

  void setSnakBarShown(bool shown){
    emit(state.copyWith(snackBarShown: shown));
  }

  Future<void> onSubmitted() async{
    emit(state.copyWith(status: FormStatus.validating));
    validatePersonalData();
    validateFoundationData();
    if(state.status == FormStatus.error){
      return;
    }
    
    emit(state.copyWith(status: FormStatus.submitting));
    final res = await repository.createUpdateChild(state.child, state.id);
    res.isSuccessful() ? emit(state.copyWith(status: FormStatus.success)) : emit(state.copyWith(status: FormStatus.error, errors: res.getError().toString()));    
  }

  
  Future<void> init(String? id) async{    
    if(id != null && id.isNotEmpty){
      emit(state.copyWith(status: FormStatus.loading));
      final res = await repository.getChild(id);
      res.isSuccessful() ? emit(state.copyWith(child: res.getValue(), id: id, status: FormStatus.initial)) : emit(state.copyWith(errors: res.getError().toString(), status: FormStatus.error));
    }
  }

  void validatePersonalData(){
    setSnakBarShown(false);

    if(state.child.name == null || state.child.name!.isEmpty || state.child.name!.length <2){
      emit(state.copyWith(errors: 'Nombre Requerido', status: FormStatus.error));
      return;
    }
    
    if(state.child.lastName == null || state.child.lastName!.isEmpty || state.child.lastName!.length <2){
      emit(state.copyWith(errors: 'Apellido Requerido', status: FormStatus.error));
      return;
    }
    
    if(state.child.personalId != null && state.child.personalId!.isNotEmpty && state.child.personalId!.length < 8){
      emit(state.copyWith(errors: 'Cédula Inválida', status: FormStatus.error));
      return;
    }

    if(state.child.birthCertificate != null && state.child.birthCertificate!.isNotEmpty && state.child.birthCertificate!.length < 5){
      emit(state.copyWith(errors: 'Certificado Inválido', status: FormStatus.error));
      return;
    }
    
    emit(state.copyWith(errors: null, status: FormStatus.valid));
    return;
  }

  void validateFoundationData(){

    setSnakBarShown(false);

    if(state.child.foundationId == null || state.child.foundationId!.isEmpty || state.child.foundationId!.length < 4){
      emit(state.copyWith(errors: 'Nro Expediente Requerido >=4', status: FormStatus.error));
      return;
    }
    if(state.child.history.courtId == null || state.child.history.courtId!.isEmpty || state.child.history.courtId!.length <4){
      emit(state.copyWith(errors: 'Nro Expediente Tribunal Requerido >=4', status: FormStatus.error));
      return;
    }
    if(state.child.history.entryDate.isEmpty){
      emit(state.copyWith(errors: 'Fecha de Ingreso Requerida', status: FormStatus.error));
      return;
    }
    if(state.child.history.entryReason.isEmpty){
      emit(state.copyWith(errors: 'Motivo de Ingreso Requerido', status: FormStatus.error));
      return;
    }
    if(state.child.history.organization == null || state.child.history.organization!.isEmpty){
      emit(state.copyWith(errors: 'Organización Judicial Requerida', status: FormStatus.error));
      return;
    }
    emit(state.copyWith(errors: null, status: FormStatus.valid ));
    return;
  }

  void setName(String name) {
    emit(state.copyWith(child: state.child.copyWith(name: name)));
  }

  void setLastName(String lastname) {
      emit(state.copyWith(child: state.child.copyWith(lastName: lastname)));
  }

  void setBirthCertificate(String text){

    emit(state.copyWith(child: state.child.copyWith(birthCertificate: text)));
  }

  void setIdentification(String id){ 
    emit(state.copyWith(child: state.child.copyWith(personalId: id)));
  }

  void pushResponsibleName(String name){
    emit(state.copyWith(child: state.child.copyWith(responsible: state.child.responsible.copyWith(
      names: state.child.responsible.names == null ? [name] : [...state.child.responsible.names!, name]
    ))));
  }

  void popResponsibleName(String name){
    emit(state.copyWith(child: state.child.copyWith(responsible: state.child.responsible.copyWith(
      names: state.child.responsible.names == null ? [] : state.child.responsible.names!.where((element) => element != name).toList()
    ))));
  }

  void pushResponsibleDoc(String doc){
    emit(state.copyWith(child: state.child.copyWith(responsible: state.child.responsible.copyWith(
      docsId: state.child.responsible.docsId == null ? [doc] : [...state.child.responsible.docsId!, doc]
    ))));
  }

  void popResponsibleDoc(String doc){
    emit(state.copyWith(child: state.child.copyWith(responsible: state.child.responsible.copyWith(
      docsId: state.child.responsible.docsId == null ? [] : state.child.responsible.docsId!.where((element) => element != doc).toList()
    ))));
  }

  void pushResponsibleContact(String contact){
    emit(state.copyWith(child: state.child.copyWith(responsible: state.child.responsible.copyWith(
      contactNro: state.child.responsible.contactNro == null ? [contact] : [...state.child.responsible.docsId!, contact]
    ))));
  }

  void popResponsibleContact(String contactNro){
    emit(state.copyWith(child: state.child.copyWith(responsible: state.child.responsible.copyWith(
      contactNro: state.child.responsible.contactNro == null ? [] : state.child.responsible.docsId!.where((element) => element != contactNro).toList()
    ))));
  }

  void setFoundationId(String id){
    emit(state.copyWith(child: state.child.copyWith(foundationId: id)));
  }
  
  void setFoundationCorteId(String id){
    emit(state.copyWith(child: state.child.copyWith(
      history: state.child.history.copyWith(courtId: id)
    )));
  }

  void pushFoundationEntryDate(DateTime date){
    emit(state.copyWith(child: state.child.copyWith(history: state.child.history.copyWith(
      entryDate: [...state.child.history.entryDate, formatDate(date)]
    ))));
  }

  void popFoundationEntryDate(String date){
    emit(state.copyWith(child: state.child.copyWith(history: state.child.history.copyWith(
      entryDate: state.child.history.entryDate.where((element) => element != date).toList()
    ))));
  }

  void pushFoundationDepartureDate(DateTime date){
    emit(state.copyWith(child: state.child.copyWith(history: state.child.history.copyWith(
      departureDate: [...state.child.history.departureDate, formatDate(date)]
    ))));
  }

  void popFoundationDepartureDate(String date){
    emit(state.copyWith(child: state.child.copyWith(history: state.child.history.copyWith(
      departureDate: state.child.history.departureDate.where((element) => element != date).toList()
    ))));
  }

  void pushEntryReason(String reason){
    emit(state.copyWith(child: state.child.copyWith(history: state.child.history.copyWith(
      entryReason: [...state.child.history.entryReason, reason]
    ))));
  }

  void popEntryReason(String reason){
    emit(state.copyWith(child: state.child.copyWith(history: state.child.history.copyWith(
      entryReason: state.child.history.entryReason.where((element) => element != reason).toList()
    ))));
  }
  
  void setFoundationDepartureReason(String reason){
    emit(state.copyWith(child: state.child.copyWith(
      history: state.child.history.copyWith(departureReason: reason)
    )));
  }

  void setFoundationOrganization(String organization){
    emit(state.copyWith(child: state.child.copyWith(
      history: state.child.history.copyWith(organization: organization)
    )));
  }
}

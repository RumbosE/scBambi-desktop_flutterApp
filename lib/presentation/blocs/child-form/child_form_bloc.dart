import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';

part 'child_form_state.dart';

final Child initChild = Child(id: '', responsible: Responsible(), history: FoundationHistory());

class ChildFormCubit extends Cubit<ChildFormState> {
  
  ChildFormCubit(): super(ChildFormState(child:initChild));

  void onSubmitted() {}

  void validatePersonalData(){
    if(state.child.name == null || state.child.name!.isEmpty){
      emit(state.copyWith(errors: 'Nombre Requerido', status: FormStatus.error));
      return;
    }
    if(state.child.lastName == null || state.child.lastName!.isEmpty){
      emit(state.copyWith(errors: 'Apellido Requerido', status: FormStatus.error));
      return;
    }
    if(state.child.birthDate == null || state.child.birthDate!.isEmpty){
      emit(state.copyWith(errors: 'Fecha de Nacimiento Requerida', status: FormStatus.error));
      return;
    }
    emit(state.copyWith(errors: null));
    print(state.child.birthDate);
    return;
  }

  void setName(String name) { 
      emit(state.copyWith(child: state.child.copyWith(name: name), status: FormStatus.validating));
  
  }

  void setLastName(String lastname) {
      emit(state.copyWith(child: state.child.copyWith(lastName: lastname), status: FormStatus.validating));
  }

  void setBirthDate(DateTime date){
    emit(state.copyWith(child: state.child.copyWith(birthDate: date.toString()), status: FormStatus.validating));
  }

  void setIdentification(String id){
    emit(state.copyWith(child: state.child.copyWith(personalId: id), status: FormStatus.validating));
  }
}

import 'package:sc_flutter_app/domain/child/datasource/child_datasource.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';



var eduardo = Child(
    id: '1',
    name: 'Eduardo',
    lastName: 'Rumbos',
    personalId: '28386360',
    birthDate: '27/08/2002',
    history: FoundationHistory(entryDate:'25/01/2020', departureDate: '11/10/2022'),

  );

class ApiChildDatasourceImpl extends ChildDatasource {
  @override
  Future<void> createUpdateChild(Child child) {
    // TODO: implement createUpdateChild
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChild(String id) {
    // TODO: implement deleteChild
    throw UnimplementedError();
  }

  @override
  Future<Child> getChild(String id) async {

    //? retorno mi objeto mientras el back no esta listo
    return eduardo;
  }

  @override
  Future<List<Child>> getChildren() async {

    final List<Child> lista = []; 

    lista.add(eduardo);
    
    return lista;
  }
}

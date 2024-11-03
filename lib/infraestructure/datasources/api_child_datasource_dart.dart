import 'package:sc_flutter_app/domain/child/datasource/child_datasource.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';

var localChildren = [
  Child(
    id: '1',
    name: 'Eduardo',
    lastName: 'Rumbos',
    personalId: '28386360',
    birthDate: '27/08/2002',
    responsible: Responsible(names: ['Antonio RUmbos', 'Luisa isa'], docsId: ['123123123', '123123123'], contactNro: ['123123123', '123123123']),
    history:
        FoundationHistory(courtId:'213123123',entryDate: '25/01/2020', departureDate: '11/10/2022', organization: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
  ),
  Child(
    id: '2',
    name: 'Alfonso',
    lastName: 'Davies',
    personalId: '123123123',
    birthDate: '21/02/2001',
    responsible: Responsible(names: ['Alfonso Padre'], contactNro: ['123123123', '123123123']),
    history:
        FoundationHistory(entryDate: '25/01/2020', departureDate: '11/10/2022'),
  )
];

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
    
    return localChildren.firstWhere((c) => c.id == id);
  }

  @override
  Future<List<Child>> getChildren() async {
    //final List<Child> lista = [];

    return localChildren;
  }
}

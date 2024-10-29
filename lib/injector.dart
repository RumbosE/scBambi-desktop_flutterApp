import 'package:get_it/get_it.dart';
import 'package:sc_flutter_app/infraestructure/datasources/api_child_datasource_dart.dart';
import 'package:sc_flutter_app/infraestructure/repositories/child_repository_impl.dart';
import 'package:sc_flutter_app/presentation/blocs/child-details/child_bloc.dart';
import 'package:sc_flutter_app/presentation/blocs/children/child_bloc_bloc.dart';



final getIt = GetIt.instance;

class Injector {
  void setUp() {

    //? inicializando las dependencias de modulo child
    final ApiChildDatasourceImpl apiChildDatasourceImpl = ApiChildDatasourceImpl();
    final repositoryChild = ChildRepositoryImpl(childDatasource: apiChildDatasourceImpl);

    getIt.registerFactory(() => ChildrenBlocBloc(repositoryChild));

    getIt.registerFactory(() => ChildBloc(repositoryChild));
  }

}
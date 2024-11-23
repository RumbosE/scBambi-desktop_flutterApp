import 'package:get_it/get_it.dart';
import 'package:bambi_socio_legal_scapp/infraestructure/datasources/api_child_datasource_dart.dart';
import 'package:bambi_socio_legal_scapp/infraestructure/repositories/child_repository_impl.dart';
import 'package:bambi_socio_legal_scapp/presentation/blocs/child-details/child_bloc.dart';
import 'package:bambi_socio_legal_scapp/presentation/blocs/child-form/child_form_bloc.dart';
import 'package:bambi_socio_legal_scapp/presentation/blocs/children/child_bloc_bloc.dart';
import 'package:bambi_socio_legal_scapp/presentation/blocs/delete-child/bloc/delete_child_bloc.dart';
import 'package:bambi_socio_legal_scapp/presentation/blocs/search-filter/search_filter_cubit.dart';



final getIt = GetIt.instance;

class Injector {
  void setUp() {

    //? inicializando las dependencias de modulo child
    final ApiChildDatasourceImpl apiChildDatasourceImpl = ApiChildDatasourceImpl();
    final repositoryChild = ChildRepositoryImpl(childDatasource: apiChildDatasourceImpl);

    final ChildrenBlocBloc childrenBloc = ChildrenBlocBloc(repositoryChild);

    final DeleteChildBloc deleteChildBloc = DeleteChildBloc(repositoryChild);

    getIt.registerFactory(() => deleteChildBloc);

    getIt.registerFactory(() => childrenBloc);

    getIt.registerFactory(() => SearchFilterCubit(childrenBloc));

    getIt.registerFactory(() => ChildBloc(repositoryChild));

    getIt.registerFactory(() => ChildFormCubit(repository: repositoryChild));

  }

}
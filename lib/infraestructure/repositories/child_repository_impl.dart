


import 'package:sc_flutter_app/common/result.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';
import 'package:sc_flutter_app/domain/child/repositories/child_repository.dart';
import 'package:sc_flutter_app/infraestructure/datasources/api_child_datasource_dart.dart';

class ChildRepositoryImpl extends ChildRepository {

  final ApiChildDatasourceImpl childDatasource;

  ChildRepositoryImpl({required this.childDatasource});

  @override
  Future<Result<void>> createUpdateChild(Child child) {
    // TODO: implement createUpdateChild
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteChild(String id) {
    // TODO: implement deleteChild
    throw UnimplementedError();
  }

  @override
  Future<Result<Child>> getChild(String id) async {

    try {
      final child = await childDatasource.getChild(id);

      return Result<Child>.success(child);

    } catch(error, _) {
      return Result<Child>.fail(error as Exception);
    }
  }

  @override
  Future<Result<List<Child>>> getChildren() async {

    try {
      final children = await childDatasource.getChildren();

      return Result<List<Child>>.success(children);

    } catch(error, _) {
      return Result<List<Child>>.fail(error as Exception);
    }

  }

}
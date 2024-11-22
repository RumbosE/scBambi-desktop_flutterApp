


import 'package:sc_flutter_app/common/result.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';
import 'package:sc_flutter_app/domain/child/repositories/child_repository.dart';
import 'package:sc_flutter_app/infraestructure/datasources/api_child_datasource_dart.dart';

class ChildRepositoryImpl extends IChildRepository {

  final ApiChildDatasourceImpl childDatasource;

  ChildRepositoryImpl({required this.childDatasource});

  @override
  Future<Result<bool>> createUpdateChild(Child child, String? id) async {
      
      try {
      await childDatasource.createUpdateChild(child, id);
      return Result<bool>.success(true);
    } catch (e,s) {
      print('error en el repositorio: $e , $s');
      return Result<bool>.fail(Exception('Failed on update: ${e.toString()}'));
    }
  }

  @override
  Future<Result<bool>> deleteChild(String id) async {
    try {
      await childDatasource.deleteChild(id);
      return Result<bool>.success(true);
    } catch(e) {
      return Result<bool>.fail(Exception('Failed on delete child: ${e.toString()}'));
    }
  }

  @override
  Future<Result<Child>> getChild(String id) async {

    try {
      final child = await childDatasource.getChild(id);

      return Result<Child>.success(child);

    } catch(e) {
      return Result<Child>.fail(Exception('Failed to fetch child: ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<Child>>> getChildren(String param, int page, int perPage) async {

    try {
      final children = await childDatasource.getChildren(param, page, perPage);

      return Result<List<Child>>.success(children);

    } catch(e) {
      return Result<List<Child>>.fail(Exception('Failed to fetch children: ${e.toString()}'));
    }

  }

}
import 'package:bambi_socio_legal_scapp/common/result.dart';
import 'package:bambi_socio_legal_scapp/domain/child/entities/child.dart';
import 'package:bambi_socio_legal_scapp/domain/child/repositories/child_repository.dart';
import 'package:bambi_socio_legal_scapp/infraestructure/datasources/api_child_datasource_dart.dart';
import 'package:dio/dio.dart';

class ChildRepositoryImpl extends IChildRepository {

  final ApiChildDatasourceImpl childDatasource;

  ChildRepositoryImpl({required this.childDatasource});

  @override
  Future<Result<bool>> createUpdateChild(Child child, String? id) async {
      
      try {
      await childDatasource.createUpdateChild(child, id);
      return Result<bool>.success(true);
    } on DioException catch (dioError) {
      print('Dio error en el repositorio: $dioError');
      return Result<bool>.fail(Exception('Dio error on update: ${dioError.message}'));
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
    } on DioException catch (dioError) {
      print('Dio error en el repositorio: $dioError');
      return Result<bool>.fail(Exception('Dio error on delete child: ${dioError.message}'));
    } catch(e) {
      return Result<bool>.fail(Exception('Failed on delete child: ${e.toString()}'));
    }
  }

  @override
  Future<Result<Child>> getChild(String id) async {

    try {
      final child = await childDatasource.getChild(id);

      return Result<Child>.success(child);

    } on DioException catch (dioError) {
      print('Dio error en el repositorio: $dioError');
      return Result<Child>.fail(Exception('Dio error to fetch child: ${dioError.message}'));
    } catch(e) {
      return Result<Child>.fail(Exception('Failed to fetch child: ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<Child>>> getChildren(String param, int page, int perPage) async {

    try {
      final children = await childDatasource.getChildren(param, page, perPage);

      return Result<List<Child>>.success(children);

    } on DioException catch (dioError) {
      print('Dio error en el repositorio: $dioError');
      return Result<List<Child>>.fail(Exception('Dio error to fetch children: ${dioError.message}'));
    } catch(e) {
      return Result<List<Child>>.fail(Exception('Failed to fetch children: ${e.toString()}'));
    }

  }

}
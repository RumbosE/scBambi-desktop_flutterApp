import 'package:bambi_socio_legal_scapp/domain/child/datasource/child_datasource.dart';
import 'package:bambi_socio_legal_scapp/domain/child/entities/child.dart';
import 'package:bambi_socio_legal_scapp/infraestructure/core/enviroments.dart';
import 'package:dio/dio.dart';


class ApiChildDatasourceImpl extends ChildDatasource {

  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/kid_record'));

  @override
  Future<void> createUpdateChild(Child child, String? id) async {

    final c=child.toJson();
try {
    if (id == null) {
      await dio.post('/', data: c);
    } else {
      await dio.put('/$id/', data: c);
    }
  } on DioException catch (e) {
    if (e.response?.statusCode == 422) {
      // Maneja el error 422 aquí
      print('Error 422: ${e.response?.data}');
    } else {
      // Maneja otros errores aquí
      print('Error: ${e.message}');
    }
    rethrow;
  }
  }

  @override
  Future<void> deleteChild(String id) async{

    await dio.delete('/delete/$id');
    return;
  }

  @override
  Future<Child> getChild(String id) async {

    final res = await dio.get('/$id');

    final child = Child.oneFromJson(res.data);

    return child;
  }

  @override
  Future<List<Child>> getChildren(String param, int page, int perPage) async {
    
    final res = await dio.get('/', queryParameters: {
      'q': param,
      'page': page,
      'perPage': perPage,
    });

    final List<Child> children = [];

    for (var child in res.data ?? []) {
      final childrenRes = Child.manyFromJson(child);
      children.add(childrenRes);
    }

    return children;
  }
}

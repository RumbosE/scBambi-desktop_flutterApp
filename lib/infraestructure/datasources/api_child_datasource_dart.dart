import 'package:sc_flutter_app/domain/child/datasource/child_datasource.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';
import 'package:sc_flutter_app/infraestructure/core/enviroments.dart';
import 'package:dio/dio.dart';


class ApiChildDatasourceImpl extends ChildDatasource {

  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/kid_record'));

  @override
  Future<void> createUpdateChild(Child child, String? id) async {

    if (id == null) {
      await dio.post('/', data: child.toJson());
    } else {
      await dio.put('/$id', data: child.toJson());
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

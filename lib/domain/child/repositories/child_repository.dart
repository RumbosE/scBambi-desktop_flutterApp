import 'package:bambi_socio_legal_scapp/common/result.dart';
import 'package:bambi_socio_legal_scapp/domain/child/entities/child.dart';

abstract class IChildRepository {
  Future<Result<Child>> getChild(String id);
  Future<Result<List<Child>>> getChildren(String param, int page, int perPage);
  Future<Result<bool>> createUpdateChild(Child child, String? id);
  Future<Result<bool>> deleteChild(String id);
}
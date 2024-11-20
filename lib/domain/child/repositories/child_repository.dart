import 'package:sc_flutter_app/common/result.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';

abstract class IChildRepository {
  Future<Result<Child>> getChild(String id);
  Future<Result<List<Child>>> getChildren(String param, int page, int perPage);
  Future<Result<bool>> createUpdateChild(Child child, String? id);
  Future<Result<bool>> deleteChild(String id);
}
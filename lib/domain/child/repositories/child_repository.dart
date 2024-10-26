import 'package:sc_flutter_app/common/result.dart';
import 'package:sc_flutter_app/domain/child/entities/child.dart';

abstract class ChildRepository {
  Future<Result<Child>> getChild(String id);
  Future<Result<List<Child>>> getChildren();
  Future<Result<void>> createUpdateChild(Child child);
  Future<Result<void>> deleteChild(String id);
}
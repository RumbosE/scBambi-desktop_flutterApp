import 'package:sc_flutter_app/domain/child/entities/child.dart';

abstract class ChildDatasource {
  Future<Child> getChild(String id);
  Future<List<Child>> getChildren(String param, int page, int perPage);
  Future<void> createUpdateChild(Child child, String? id);
  Future<void> deleteChild(String id);
}


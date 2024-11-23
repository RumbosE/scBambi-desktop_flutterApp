import 'package:bambi_socio_legal_scapp/domain/child/entities/child.dart';

abstract class ChildDatasource {
  Future<Child> getChild(String id);
  Future<List<Child>> getChildren(String param, int page, int perPage);
  Future<void> createUpdateChild(Child child, String? id);
  Future<void> deleteChild(String id);
}


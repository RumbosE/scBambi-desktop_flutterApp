import 'package:sc_flutter_app/domain/child/entities/child.dart';

abstract class ChildRepository {
  Future<Child> getChild(String id);
  Future<List<Child>> getChildren();
  Future<void> createUpdateChild(Child child);
  Future<void> deleteChild(String id);
}
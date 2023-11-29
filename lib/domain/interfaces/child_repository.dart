import 'package:santas_list/domain/models/child.dart';

abstract class IChildRepository {
  List<Child> getChildren();
  Child addChild(Child child);
  Child updateChild(Child child);
}
import 'package:santas_list/data/local/child_data_store.dart';
import 'package:santas_list/domain/interfaces/child_repository.dart';
import 'package:santas_list/domain/models/child.dart';

class ChildRepository implements IChildRepository {
  final ChildDataStore childDataStore; // Repository using a ChildDataStore for data handling

  const ChildRepository(this.childDataStore); // Constructor initializing the ChildDataStore

  @override
  Child addChild(Child child) {
    return childDataStore.saveChild(child); // Method to add a new child using the ChildDataStore
  }

  @override
  List<Child> getChildren() {
    return childDataStore.getChildren(); // Method to retrieve children using the ChildDataStore
  }

  @override
  Child updateChild(Child child) {
    return childDataStore.updateChild(child); // Method to update a child using the ChildDataStore
  }
}

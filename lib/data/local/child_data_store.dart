import 'package:santas_list/domain/models/child.dart';
import 'package:santas_list/domain/models/status.dart';

class ChildDataStore {
  final List<Child> _children = [
    // Initial list of children with their details and statuses
    Child(id: 1, name: "John", country: "USA", status: Status.naughty),
    Child(id: 2, name: "Jane", country: "USA", status: Status.nice),
    Child(id: 3, name: "Jack", country: "USA", status: Status.naughty),
    Child(id: 4, name: "Jill", country: "USA", status: Status.nice),
  ];

  // Method to save a new child to the datastore
  Child saveChild(Child child) {
    child = child.copyWith(id: _children.length + 1); // Assigns a new ID to the child
    _children.add(child); // Adds the new child to the list
    return child; // Returns the added child
  }

  // Method to retrieve the list of children from the datastore
  List<Child> getChildren() {
    return _children; // Returns the list of children
  }

  // Method to update an existing child in the datastore
  Child updateChild(Child child) {
    final index = _children.indexWhere((element) => element.id == child.id); // Finds the index of the child to update
    _children[index] = child; // Updates the child at the found index
    return child; // Returns the updated child
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santas_list/domain/models/child.dart';
import 'package:santas_list/domain/models/status.dart';
import 'package:santas_list/ui/bloc/bloc/update_child_bloc.dart'; 
import 'package:santas_list/ui/bloc/get_children/get_children_bloc.dart';
import 'package:santas_list/ui/widgets/child_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key}); 
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<GetChildrenBloc>(context).add(GetChildren());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
              context, '/add'), // Navigates to the 'Add Child' screen
          child: const Icon(Icons.add)),
      body: BlocBuilder<GetChildrenBloc, GetChildrenState>(
        builder: (context, state) {
          if (state is GetChildrenLoading) {
            return const CircularProgressIndicator(); // Displays a loading indicator while fetching children
          } else if (state is GetChildrenSuccess) {
            return ListView.builder(
                itemCount: state.children.length,
                itemBuilder: (context, index) {
                  return ChildListTile(
                    name: state.children[index].name,
                    country: state.children[index].country,
                    status: state.children[index].status,
                    onTap: () {
                      showUpdateDialog(
                          context,
                          state.children[
                              index]); // Shows a dialog to update child status
                    },
                  );
                });
          } else {
            return const Center(
              child: Text(
                  "List is Empty"), // Displays a message when the list is empty
            );
          }
        },
      ),
    );
  }

  void updateChild(BuildContext context, Child child) {// Debug message for child update
    BlocProvider.of<UpdateChildBloc>(context)
        .add(UpdateChild(child)); // Triggers an update for the child
    setState(() {}); // Triggers a rebuild after child update
  }

  void showUpdateDialog(BuildContext context, Child child) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        String? selectedItem =
            child.status.name; // Retrieves the initial selected status
        // Creating a list of available options
        List<String> items = [Status.nice.name, Status.naughty.name];

        return AlertDialog(
          title: const Text(
              'Update Child Status'), // Dialog title for updating child status
          content: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: selectedItem,
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue; // Updates selected status
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(buildContext).pop(); // Closes the dialog on cancel
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(buildContext).pop(); // Closes the dialog on update
                // Handles the selected item and updates the child's status
                if (selectedItem == Status.nice.name) {
                  updateChild(context, child.copyWith(status: Status.nice));
                } else if (selectedItem == Status.naughty.name) {
                  updateChild(context, child.copyWith(status: Status.naughty));
                }
              },
              child: const Text('Update'), // Button to update child status
            ),
          ],
        );
      },
    );
  }
}

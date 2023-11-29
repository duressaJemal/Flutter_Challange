import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santas_list/domain/models/child.dart';
import 'package:santas_list/domain/models/status.dart';
import 'package:santas_list/ui/bloc/add_child/add_children_bloc.dart';
import 'package:santas_list/ui/bloc/get_children/get_children_bloc.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key}); 

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  bool isNice = true; // Represents the initial status as 'nice'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Child',
        ),
      ),
      body: BlocListener<AddChildrenBloc, AddChildrenState>(
        listener: (context, state) {
          // Handles state changes when adding a child
          if (state is AddChildrenSuccess) {
            Navigator.pop(context); // Closes the current screen on successful addition
            context.read<GetChildrenBloc>().add(GetChildren()); // Triggers fetching updated children
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Child Added'))); // Shows a success message
          } else if (state is AddChildrenError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message))); // Displays an error message if adding fails
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: countryController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Country'),
              ),
              const SizedBox(height: 20),
              DropdownButton<bool>(
                value: isNice,
                onChanged: (newValue) {
                  setState(() {
                    isNice = newValue!; // Updates the selected status value
                  });
                },
                items:  [
                  DropdownMenuItem<bool>(
                    value: true,
                    child: Text(Status.nice.name),
                  ),
                  DropdownMenuItem<bool>(
                    value: false,
                    child: Text(Status.naughty.name),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<AddChildrenBloc, AddChildrenState>(
                builder: (context, state) {
                  if (state is AddChildrenLoading) {
                    return const Center(
                      child: CircularProgressIndicator(), // Shows a loading indicator while adding a child
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        final String name = nameController.text;
                        final String country = countryController.text;

                        context.read<AddChildrenBloc>().add(AddChildren(Child(
                            name: name,
                            country: country,
                            status: isNice ? Status.nice : Status.naughty))); // Adds a new child based on entered details
                      },
                      child: const Text('Add Child'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

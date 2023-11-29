import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santas_list/data/local/child_data_store.dart';
import 'package:santas_list/data/repository/child_repository.dart';
import 'package:santas_list/ui/add_child.dart';
import 'package:santas_list/ui/bloc/add_child/add_children_bloc.dart';
import 'package:santas_list/ui/bloc/bloc/update_child_bloc.dart';
import 'package:santas_list/ui/bloc/get_children/get_children_bloc.dart';
import 'package:santas_list/ui/home.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (context) => ChildRepository(
          ChildDataStore()), // Repository setup with ChildRepository and ChildDataStore
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                GetChildrenBloc(context.read<ChildRepository>())
                  ..add(GetChildren()), // Bloc for getting children information
          ),
          BlocProvider(
            create: (context) => UpdateChildBloc(context
                .read<ChildRepository>()), // Bloc for updating child data
          ),
          BlocProvider(
            create: (context) => AddChildrenBloc(
                context.read<ChildRepository>()), // Bloc for adding children
          ),
        ],
        child: const MyApp(), // Wraps the entire app with providers
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Santa\'s List',
        routes: {
          '/home': (context) => const HomePage(), // Route for the home page
          '/add': (context) =>
              const AddChildScreen(), // Route for adding a child
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple), // Customized theme color
          useMaterial3: true, // Using Material 3 design
        ),
        home: const HomePage()); // Sets the initial home page
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_app/controller/functions_controller.dart';
import 'package:flutter_firebase_todo_app/model/todo_model.dart';
import 'package:flutter_firebase_todo_app/view/add_screen.dart';
import 'package:flutter_firebase_todo_app/view/update_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FunctionsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: StreamBuilder<List<TodoModel>>(
          stream: provider.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching data'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  TodoModel data = snapshot.data![index];
                  final name = data.name.toString();
                  final subName = data.subName.toString();
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdateScreen(
                            docId: data.id.toString(),
                          ),
                        ),
                      );
                    },
                    title: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(data.id.toString()),
                    trailing: ElevatedButton(
                      onPressed: () {
                        provider.deleteData(data.id!);
                      },
                      child: const Text('DELETE'),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

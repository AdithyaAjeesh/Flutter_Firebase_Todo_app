import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_app/controller/functions_controller.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  final String docId;
  final bool isDone;
  const UpdateScreen({super.key, required this.docId, required this.isDone});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FunctionsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: provider.nameController,
            ),
            TextField(
              controller: provider.subNameController,
            ),
            ElevatedButton(
              onPressed: () {
                provider.updateData(docId, isDone);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
